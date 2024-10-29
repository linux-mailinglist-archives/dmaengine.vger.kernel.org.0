Return-Path: <dmaengine+bounces-3634-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5189B45D4
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7BC1C2141A
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9A2038A3;
	Tue, 29 Oct 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MFpph/jB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Aq9To5J4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MFpph/jB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Aq9To5J4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC652036F4;
	Tue, 29 Oct 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194667; cv=none; b=FVPzxgv6yWbm0W3SVNS25NOhoST3O+WgClRxP/rkMVPHBXPPPto8cd5mQjlBduXZ4mr8Huw/V9QYSNtgMVBnUP1CRbqmM+EqRnlydFkf1cZZl2p88td02hzNAONGBgL+ni1rxuPL1ytitn5h8YdxBBlbSyWAvfiW5V1lxkLuA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194667; c=relaxed/simple;
	bh=hhTbhQy5WqBCVGKga+NQ+/BK9Sfjhrxqz0X4EmpeUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr5fikzOucsicRJDGUh/U4XFYe9BBjkJgtnXDv8fpYN+GXi0Om9FuvcRQz1SVnR1PiAzy4Kw8tp2KrcXqhbDQTZJFn0qftFN0qopBWZoFcQ8WF3AcsemjycPgr6CbsQ7QX1cCYnT9SauZAsI42IhV6uRKUGxlhEkeoueq91nCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MFpph/jB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aq9To5J4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MFpph/jB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aq9To5J4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04DC821CB5;
	Tue, 29 Oct 2024 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730194664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0axVOqoMls//Wk+pvC5XHfu4g+8K4S/uESA90ZpiSro=;
	b=MFpph/jBB1J/ISr6NeT9WLZmTaOCpka/EFPFi79RpcQDXvUb6gXFq2uiaw9Znyk9eyFz3H
	ReVfuHyJDoUtN4FNxVwYSXTY9xburM0eD3Qxpfz59mKLKgamQMVHy7RqBu1hs5/SFFJPLw
	DRRSdlBNDz7zfFGhJ+J9+C59ZyUJtp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730194664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0axVOqoMls//Wk+pvC5XHfu4g+8K4S/uESA90ZpiSro=;
	b=Aq9To5J4OyWv9MZ1wXaqA99S23W+n2hHs6LsWZOc48A04RFALqgDjs6OHKARjcxMxsOhZx
	5NEMh2sW95cAg9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730194664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0axVOqoMls//Wk+pvC5XHfu4g+8K4S/uESA90ZpiSro=;
	b=MFpph/jBB1J/ISr6NeT9WLZmTaOCpka/EFPFi79RpcQDXvUb6gXFq2uiaw9Znyk9eyFz3H
	ReVfuHyJDoUtN4FNxVwYSXTY9xburM0eD3Qxpfz59mKLKgamQMVHy7RqBu1hs5/SFFJPLw
	DRRSdlBNDz7zfFGhJ+J9+C59ZyUJtp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730194664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0axVOqoMls//Wk+pvC5XHfu4g+8K4S/uESA90ZpiSro=;
	b=Aq9To5J4OyWv9MZ1wXaqA99S23W+n2hHs6LsWZOc48A04RFALqgDjs6OHKARjcxMxsOhZx
	5NEMh2sW95cAg9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D170C136A5;
	Tue, 29 Oct 2024 09:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JKDMMuesIGc+HwAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 29 Oct 2024 09:37:43 +0000
Date: Tue, 29 Oct 2024 11:44:45 +0200
From: "Ivan T . Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH V5 1/9] Revert "usb: dwc2: Skip clock gating on Broadcom
 SoCs"
Message-ID: <20241029094445.hsporitxkv2q45c5@localhost.localdomain>
References: <20241025103621.4780-1-wahrenst@gmx.net>
 <20241025103621.4780-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025103621.4780-2-wahrenst@gmx.net>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,broadcom.com,kernel.org,linaro.org,synopsys.com,linuxfoundation.org,wunner.de,gmail.com,lists.infradead.org,raspberrypi.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Stefan,

On 10-25 12:36, Stefan Wahren wrote:
> 
> The commit d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
> introduced a regression on Raspberry Pi 3 B Plus, which prevents
> enumeration of the onboard Microchip LAN7800 in case no external USB device
> is connected during boot.
> 
> Fixes: d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/usb/dwc2/params.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 68226defdc60..4d73fae80b12 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -23,7 +23,6 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
>  	p->max_transfer_size = 65535;
>  	p->max_packet_count = 511;
>  	p->ahbcfg = 0x10;
> -	p->no_clock_gating = true;
>  }
> 

Thanks, this makes RPi3 Ethernet operational again.

Tested-by: Ivan T. Ivanov <iivanov@suse.de>

Regards.


