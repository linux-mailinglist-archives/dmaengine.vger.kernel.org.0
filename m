Return-Path: <dmaengine+bounces-8418-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIWLC45ccGm8XgAAu9opvQ
	(envelope-from <dmaengine+bounces-8418-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 05:56:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 595045140F
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 05:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD96A38430E
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD932692D;
	Wed, 21 Jan 2026 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="sfef7a/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E710ZbFk"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D43C00B5;
	Wed, 21 Jan 2026 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971399; cv=none; b=DnBxZMe0U+2aGnWn8r+8yhDkgG59INkbtPKNgya5H5iVWy46UbYVL0GSsegErKrvm9JsK59ZuAP0GRcfVORkhJNgWGIYMrgaHpWquiGL1MOw9gu+iX7p5zZVhUzdUtOq7XseyyqcfgpFTQtaBtyLWBhhB2wtXDrt0BCmSe56gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971399; c=relaxed/simple;
	bh=M9FBsQ8l2dM7sBIZmQ71XB6s8o7HJUNuRx6O1OsCoXE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sjHewP3nNkaSPSa0QQkHk2P6LyRj6fW8xvADkV5u+tJBv7JKMm05Cy582eixoyDYOVNTOeUKlyC7q0v5co8u1rXmvGTskmPuGScmhIIt2tMkW3LxcXe902WsT87h6ghUHYM1iq3rSf4gE9918Jjg4lnEoRPUWlwOcaS2fukrk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=sfef7a/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E710ZbFk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F146E7A0070;
	Tue, 20 Jan 2026 23:56:35 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 23:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768971395;
	 x=1769057795; bh=4E5ZHa5hNScS1Mn2F8/jCr3XAYcZwqjxjNyXaz6s2eE=; b=
	sfef7a/zm65eTDqKORq1H3agFdQy8dY4wZF73JBJmhftcE1AiZgm1Re1FSuxGTR5
	LQDWSlt4/GnhqxjT00T20BGNuvVMrbFYOtGYI7xbyMMrXMM8fePfutyLk2/iyEYr
	9fe+KBxrd/elcfvG7puGCNt/B/kADZXWRXxW0SSpCByOCQBBRcYf+qvyh8c9EarR
	tuCr6PTpG40FHRgZkxsbWquE8j30HcYBu53BQ4TEwygnk3TMgDVwcSyjEwg8r2Ka
	GyykniE3R5T4dqa30zHA9dqvCwdCVWVGgXIUN04RG6eWy63Bm5HwlJE9+yYvsTC0
	bonjjmR0DrMu+n64j/qjhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768971395; x=
	1769057795; bh=4E5ZHa5hNScS1Mn2F8/jCr3XAYcZwqjxjNyXaz6s2eE=; b=E
	710ZbFkvmnTJz7IpW7Ff/EwGVjNf4pRBJ2zrDBwx/+mtAL38Vb2/OMmbmEsQ8B08
	kN7/ZN50PYp4rf/O33/8TuaJJvryxqdQc/fRou9npb8N+U5FTlwinm2oAmMFT2IE
	o05TIlqbZfE77MBsowSFr2ae1zD8SoP901/8AQhpua+JiRtE6MT5OuersMx5inPY
	w9gv2EKocC0NP4Cp44vMh+jKNJWgIeZcPKZ7+69TxV+qYXZui1jsKAXrvVHbxa5Q
	j8k6Sil/W1JWOYle/oZB1JvdN2MmuN7EmDlzi8bnuiFyXY2cb4ndbrVJgqDRtUd/
	LRLWf189C2KoFMAUFXj1Q==
X-ME-Sender: <xms:g1xwae6jMSFEOVcp0vrMR0_VbxGlsCY7kfUOzoTyaywR_49scYqFaA>
    <xme:g1xwaSt0YRrJA2Y39u2l3-D5x1dL6G8nEXteX5GeZLhRYMiIoLqEc738d4JkuxPPv
    lx9n1LBKUuaSd6eOrHZ4AAMx7SgfMwJC3XUozK55ZSZe20UJ_DXnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpegtohhrrhgv
    tghtmhhoshhtuceotghmlhhishhtshesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejuedtvdehteeigeffveehhffhieevuddugfefgfekveetfeeguefhueetffduteen
    ucffohhmrghinheprghlthhlihhnuhigrdhorhhgpdhkvghrnhgvlhdrohhrghdpughrvg
    grmhifihguthhhrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheptghmlhhishhtshesshgvnhhtrdgtohhmpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhi
    nhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g1xwaciM9gWsn3N5hs_mMv1WM1XU2uWoux3mE_9rebe2VQISTFuo8g>
    <xmx:g1xwafEAI5ePHcj6NTOsxuLhOzzTITX9LxfKNJPOiEj0HiiUPyEEzA>
    <xmx:g1xwaT9IxhyUfa0ql6vfjZeR_Zz4u07uOFmgVDZDIERvipGi2bYA1w>
    <xmx:g1xwaexX0i8TYePrs2Agq15NH-kFKxdDxCUacvNh1n4Mw1y74EEWGw>
    <xmx:g1xwaUIlGiRG_bMLAf7mVOxgVBLrjyZoKNztojf4DhxfpypUtlueLeyy>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F934B6006E; Tue, 20 Jan 2026 23:56:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Tue, 20 Jan 2026 23:56:15 -0500
From: correctmost <cmlists@sent.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org, mika.westerberg@linux.intel.com
Message-Id: <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
In-Reply-To: <aW9LzBIOIePu59zV@smile.fi.intel.com>
References: <51388859-bf5f-484c-9937-8f6883393b4d@app.fastmail.com>
 <aWUGmfcjWpFJs3-X@smile.fi.intel.com>
 <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com> <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com> <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sent.com];
	TAGGED_FROM(0.00)[bounces-8418-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[sent.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,messagingengine.com:dkim,altlinux.org:url,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 595045140F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026, at 4:33 AM, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 12:49:59PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 19, 2026 at 12:39:41PM +0200, Andy Shevchenko wrote:
>> > On Fri, Jan 16, 2026 at 07:25:54PM -0500, correctmost wrote:
>> > > On Fri, Jan 16, 2026, at 5:35 AM, Andy Shevchenko wrote:
>> > > > On Fri, Jan 16, 2026 at 12:03:12PM +0200, Andy Shevchenko wrote:
>> > > >> On Thu, Jan 15, 2026 at 05:50:36PM -0500, correctmost wrote:
>> > > >> > On Mon, Jan 12, 2026, at 9:35 AM, Andy Shevchenko wrote:
>> > > >> > > On Tue, Dec 16, 2025 at 12:57:10PM -0500, correctmost wrot=
e:
>> > > >> > >
>> > > >> > >> The following commit
>> > > >> > >
>> > > >> > > No, it's false positive. The reality is that something els=
e is going on
>> > > >> > > there on this and other similar laptops.
>> > > >> > >
>> > > >> > >> causes my Lenovo IdeaPad touchpad not to work when
>> > > >> > >> kernel/drivers/dma/idma64.ko.zst is present in the initra=
mfs image:
>> > > >> > >>=20
>> > > >> > >> #regzbot introduced: 9140ce47872bfd89fca888c2f992faa51d20=
c2bc
>> > > >> > >>=20
>> > > >> > >> "idma64: Don't try to serve interrupts when device is pow=
ered off"
>> > > >> > >
>> > > >> > > So, the touchpad is an I=C2=B2C device, which is connected=
 to an Intel SoC.
>> > > >> > > The I=C2=B2C host controller is Synopsys DesignWare. On In=
tel SoCs the above
>> > > >> > > mentioned IP is generated with private DMA engine, that's =
called Intel
>> > > >> > > iDMA 64-bit. Basically it's two devices under a single PCI=
 hood.
>> > > >> > > The problem here is that when PCI device is in D3, both de=
vices are
>> > > >> > > powered off, but something sends an interrupt and it's not=
 recognized
>> > > >> > > being the one, send by a device (touchpad).
>> > > >> > >
>> > > >> > > There is one of the following potential issues (or their c=
ombinations):
>> > > >> > >
>> > > >> > > - the I=C2=B2C host controller hardware got off too early
>> > > >> > > - the line is shared with something else that generates in=
terrupt storm
>> > > >> > > - the BIOS does weird (wrong) things at a boot time, like =
not properly
>> > > >> > >   shutting down and disabling interrupt sources; also may =
have wrong
>> > > >> > >   pin control settings
>> > > >> > > - the touchpad is operating on higher frequency like 400kH=
z (because
>> > > >> > >   BIOS told to use that one instead of 100kHz) than the HW=
 is designed
>> > > >> > >   for and hence unreliable with all possible side effects
>> > > >> > > - the touchpad firmware behaves wrongly on some sequences =
(see also
>> > > >> > >   note about the bus speed above), try to upgrade touchpad=
 FW
>> > > >> > >
>> > > >> > > With my experience with the case of the above mentioned co=
mmit that it
>> > > >> > > may be BIOS thingy. Also consider the bus speed, there are=
 quirks in
>> > > >> > > the kernel for that.
>> > > >> >=20
>> > > >> > Thank you for the detailed notes.  I will see if I can updat=
e my BIOS and
>> > > >> > experiment with different quirks values, though I won't be a=
ble to do that
>> > > >> > until late next week.
>> > > >>=20
>> > > >> You're welcome!
>> > > >>=20
>> > > >> > >> Here are the related logs:
>> > > >> > >>=20
>> > > >> > >> ---
>> > > >> > >>=20
>> > > >> > >> irq 27: nobody cared (try booting with the "irqpoll" opti=
on)
>> > > >> > >
>> > > >> > > Almost all below is not so interesting.
>> > > >> > >
>> > > >> > > ...
>> > > >> > >
>> > > >> > >> handlers:
>> > > >> > >> [<00000000104a7621>] idma64_irq [idma64]
>> > > >> > >> [<00000000bd8d08e9>] i2c_dw_isr
>> > > >> > >> Disabling IRQ #27
>> > > >> > >
>> > > >> > > Yes, this line at least shared between those two and might=
 be more.
>> > > >> > >
>> > > >> > > ...
>> > > >> > >
>> > > >> > >> i2c_designware i2c_designware.0: controller timed out
>> > > >> > >> hid (null): reading report descriptor failed
>> > > >> > >> i2c_hid_acpi i2c-ELAN06FA:00: can't add hid device: -110
>> > > >> > >> i2c_hid_acpi i2c-ELAN06FA:00: probe with driver i2c_hid_a=
cpi failed with error -110
>> > > >> > >
>> > > >> > > Yes, sounds familiar with the speed settings. Try to down =
it to 100kHz in case
>> > > >> > > it's confirmed to be 400kHz.
>> > > >> > >
>> > > >> > >> ---
>> > > >> > >
>> > > >> > > Any pointers to that thread, please?
>> > > >> >=20
>> > > >> > The following threads have users who were able to restore to=
uchpad
>> > > >> > functionality by undoing the idma64 change in initramfs:
>> > > >>=20
>> > > >> Yes, =3D "they have hidden the existing problem". No value in =
that, sorry.
>> > > >> What is the exact link that refer to the thread you previously=
 mentioned?
>> > > >>=20
>> > > >> ...
>> > > >>=20
>> > > >> > Lastly, I saw another bug report that mentions the "probe wi=
th driver
>> > > >> > i2c_hid_acpi failed with error -110" error.  It seems to sta=
te that the error
>> > > >> > only occurs when a power cable is connected during boot:
>> > > >> >=20
>> > > >> > - https://bugzilla.altlinux.org/57094
>> > > >> >   - Huawei Matebook D15 BOD-WXX9-PCB-B4
>> > > >> >   - i2c-GXTP7863:00
>> > > >> >=20
>> > > >> > >> so I don't think this is a hardware issue with my individ=
ual laptop.
>> > > >> > >
>> > > >> > > I don't know how this conclusion is came here. You mean HW=
 as laptop model?
>> > > >> > > But are the involved components the same (I=C2=B2C host co=
ntroller + touchpad)?
>> > > >> >=20
>> > > >> > Sorry for the confusion.  I meant the individual machine in =
my possession and
>> > > >> > not the laptop model as a whole.
>> > > >>=20
>> > > >> Yeah, something here is common and I can't say for sure this a=
ll about Synaptic
>> > > >> touchpads...
>> > > >
>> > > > So, what I think I need to understand this more is the following
>> > > > (all information should be gathered under root user) for working
>> > > > and non-working cases:
>> > > >
>> > > > - `cat /proc/interrupts`
>> > > > - `dmesg`
>> > > >    # with `initcall_debug ignore_loglevel` added to the kernel =
command line
>> > > > - `cat /sys/kernel/debug/pinctrl/.../pins`
>> > > >    # ... should be something like INTC1234:00
>> > > >
>> > > > And just once these:
>> > > > - `acpidump -o tables.dat` # the tables.dat file
>> > > > - `grep -H 15 /sys/bus/acpi/devices/*/status`
>> > > > - `lspci -nk -vv`
>> > >=20
>> > > The tables.dat file and the dmesg logs seemed too big to post inl=
ine, so I
>> > > ended up zipping all of the files (attached).
>> >=20
>> > Thanks for the files. The same suspicion as in the original report
>> > https://lore.kernel.org/all/e3f2debf-c762-48d9-876e-bcb60841f909@gm=
ail.com/
>> >=20
>> > Have you read it in full?
>> >=20
>> > My understanding that the pin 3 on GPIO might be wrongly configured
>> > by BIOS.  The difference with the original case is that your GPIO d=
evice
>> > is locked against modifications and until you unlock it (usually
>> > it's done in BIOS in some debug menu) it may not be fixable without=
 OEM
>> > fixing the issue themselves. In any case you can try the workaround
>> > (see https://lore.kernel.org/all/ZftTcSA5dn13eAmr@smile.fi.intel.co=
m/).
>> > But I am skeptical about it.

I tested commit c03e9c42ae8 with the following patch and still saw the "=
probe with driver i2c_hid_acpi failed" error:

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/int=
el/pinctrl-intel.c
index cf9db8ac0f42..738a9f91dafd 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1681,6 +1681,19 @@ int intel_pinctrl_probe(struct platform_device *p=
dev,
=20
 	platform_set_drvdata(pdev, pctrl);
=20
+	{
+		void __iomem *padcfg0;
+	        u32 value;
+
+		padcfg0 =3D intel_get_padcfg(pctrl, 3, PADCFG0);
+
+		guard(raw_spinlock_irqsave)(&pctrl->lock);
+		value =3D readl(padcfg0);
+		value |=3D PADCFG0_GPIOTXDIS;
+		value |=3D PADCFG0_GPIORXDIS;
+		writel(value, padcfg0);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_pinctrl_probe, "PINCTRL_INTEL");

>>=20
>> Just in case, this https://hansdegoede.dreamwidth.org/25589.html migh=
t be
>> also useful.

Thanks, I will try to find out if my laptop allows access to advanced BI=
OS options.

The Lenovo support site lists some BIOS updates for my laptop, though th=
e release notes do not mention any touchpad fixes.  The updates are not =
available via fwupd, so I probably won't be able to update anytime soon.

>
> FWIW, seems familiar:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219799
>
> Have you tried similar steps described there? (Id est turning PM off a=
nd
> see if it affects the case. In your case it might be needed to comment=
 out
> the dev_pm_ops assignment in the LPSS driver drivers/mfd/intel-lpss*.c=
 and
> recompile the kernel / modules).

I tested commit c03e9c42ae8 with the following changes and still saw the=
 "probe with driver i2c_hid_acpi failed" error:

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi=
.c
index 63406026d809..4e6fdb872655 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -212,7 +212,7 @@ static struct platform_driver intel_lpss_acpi_driver=
 =3D {
 	.driver =3D {
 		.name =3D "intel-lpss",
 		.acpi_match_table =3D intel_lpss_acpi_ids,
-		.pm =3D pm_ptr(&intel_lpss_pm_ops),
+		// .pm =3D pm_ptr(&intel_lpss_pm_ops),
 	},
 };
=20
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8d92c895d3ae..7d96bf1bc808 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -656,7 +656,7 @@ static struct pci_driver intel_lpss_pci_driver =3D {
 	.probe =3D intel_lpss_pci_probe,
 	.remove =3D intel_lpss_pci_remove,
 	.driver =3D {
-		.pm =3D pm_ptr(&intel_lpss_pm_ops),
+		// .pm =3D pm_ptr(&intel_lpss_pm_ops),
 	},
 };

I also tried booting Arch's 6.18.5 kernel with the power cord unplugged =
to see if that helped, but I still saw the "i2c_hid_acpi failed" error.

It seems like the next step is to try to enable GPIO unlocking in the BI=
OS.

