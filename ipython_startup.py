'''IPython lines to run upon startup. Place the following line in
~/.ipython/profile_default/ipython_config.py:

%run -i ~/ipython_startup.py
'''

# from datetime import datetime, timedelta
# from IPython.display import display
import astropy.units as u
import astropy.units.imperial as ui
import astropy.constants as const


def effa(at, ar=None, d=100, wl=3e8/5.8e9):
    '''Return aperture-to-aperture efficiency given tx and rx areas.'''
    if ar is None:
        ar = at
    ts = at * ar / (d**2 * wl**2);
    print('Tau = {:.03f}'.format(np.sqrt(ts)))
    return 1 - np.exp(-ts)

def effd(dt, dr=None, d=20e3, wl=3e8/5.8e9):
    '''Solve for and return the aperture-to-aperture efficiency of a RF beam
    system.

    dt/dr: tx/rx diameter
    d: distance
    wl: wavelength
    '''
    at = (dt / 2)**2 * np.pi
    if dr is None:
        dr = dt
    ar = (dr / 2)**2 * np.pi
    return effa(at, ar=ar, d=d, wl=wl)

def dB(x):
    '''Convert a ratio to dB.'''
    return 10*np.log10(x)

def dBinv(x):
    '''Convert dB to a ratio.'''
    return 10**(x/10)

def G2Ae(G, wl):
    '''Convert Gain in dB to effective aperture.

    G: Gain in dB
    wl: wavelength in meters.
    returns: effective aperture in m^2
    '''
    G_ratio = dBinv(G)
    Ae = G_ratio * wl**2 / (4 * np.pi)
    return Ae

def area2radius(A):
    '''Convert an area to the radius of a circle with that area.'''
    return np.sqrt(A / np.pi)

def tau2d(tau, d, wl):
    a = np.sqrt(d**2 * wl**2 * tau**2)
    diam = np.sqrt(a/np.pi)*2
    return diam

tau = 2 * np.pi
