Return-Path: <dmaengine+bounces-10058-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PtHEFEf5mkMsAEAu9opvQ
	(envelope-from <dmaengine+bounces-10058-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 14:42:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9261E42AE02
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8DC3032CC8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9789B39C629;
	Mon, 20 Apr 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k7PI1j9L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8639BFEF
	for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688957; cv=none; b=LeLXbSRQiQx+5MLWxscHS6VZmoE/cPDyDEnvXW0cQ0gnxxnYh0QRHQMk0b4yIl6qpfy4s8DbJuwvswYBrGLHNpRlwDBoGDzzN0xNTHmqIDPHsCayJehf40MZZhHGs/Ij4FzjbPkVFSB1WRH9Gnf4G6m9WUXNJFY7ENmUselXRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688957; c=relaxed/simple;
	bh=sNWrPKdgJgN4wDqDTIFsuQqmdu9qGGj8pSrpP6xnVSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLXBPy7fEF5tka56JKTzyjYg3QWsRWN7T4UupQOQYOYE8E8pNjOSpCuB3rsueke/Kh47CB7Z+z3bcSrct3aHwE7e4n9gWmvA4RxIG2hu0RiEu2Ri0Gfr6cn+ISs7yvVr9xIy3atDS9BcWklvwFrMZQ4MaERLMBn78a46gZOBjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k7PI1j9L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488d2079582so35229465e9.2
        for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1776688952; x=1777293752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4trd1lG68gD9u1MDZvKe+ZbY4mqv6K/rfC6lhMlRK5w=;
        b=k7PI1j9LwDWTSvQxZkT4LRvWYktO+ZiMTsnsvfphQ/vxtG34qZc44HiwoWnrLfBkYp
         jkKydELyESKolL0ORuwH12TRljXASqIDf1w8E5ted9sgc6BiLcwWKGnlZbigDWiuDzZN
         J+bIiDwugYQ0LiqaIvoKUWqW6i8NItiBwA/RTEHdWur+WvidZxULQKzLdnsWyWbGlD2g
         MrDkuH2+znM1GwhFbAa9sbUEoZwmB0kTXye8B7dJ2NUTUZYTs8toKfjaUfy26X1mpf4E
         2+3P7mLYUNHX4Cnfg0kgCU/uil+Gxqs6hGoOIWZW1EUjyWCZkvPPC6hBZ8mo8VgUdQZz
         0Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688952; x=1777293752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4trd1lG68gD9u1MDZvKe+ZbY4mqv6K/rfC6lhMlRK5w=;
        b=WZ+gxhvruLTJZ8KOAx7SZRcbGLVKzcgM7qQ9j9wQpjchnmXXKmSYOWz7teSIpb/VTv
         Wmc/d03KLDNTKtvycBOQHNT9uLRTgXW1VJj0qKAomp7J8YYNl7TZndH8vbNFa4KhNi21
         bqzTVanfrnHn3F4iL3/UpycqKg2AGeMfCxwjuNLc5UrH5Mwu9jG3PINFz4Q42NviXlrT
         ySQc4m8iIzZ3N0Q/aV08mmpYQn3KoKNcq9JUcWM8tgOoHw16509XoFcigFN47ukCnpd1
         6zvDUVynStGhCeatguFNCEZH8EAlbh3847Ha3855nrSrb2qMH+CI+JCo/5+CuB9piK8k
         uonQ==
X-Gm-Message-State: AOJu0YwQcFswU+97egvZ4GnnDysz7UuAirboUmd03XLIxPciuOXMfjkJ
	ZdlrGr1Or6GP/Vm+NDYwWxkAbrgz72jdocsXqr1EeKb0zEHtgX3tGEZeYvctRMR4BGVVLR2g8Fx
	sduQB
X-Gm-Gg: AeBDietu587rl0f6rNec/k2DOSIYSJCr2s6zkXuOWDngZIwLtUas8+WQGT5HbOa6u5/
	2xDOqRQ6amLJdg95Wo3yvOrkKLSh2o3cVfarBU4HTYunZ8kX3558Eo2apPzAVy23dZFVkXw0H1F
	MtwPNg/pww5C+pvulsBrh8hERVwHLDgT4eYb285Us+Tr629pU2Y3UIuzIpnrhQPbDz4JxgERKQX
	HZTJN0EuexLFzOMf8dmTKqPEs8e7g9Gs95g3fB02WlZ6dyh50Cz+4Cv1SS9ZGK6uL2aiWWsur8P
	TkXw4rIvSi+0TY7MiVDlcAoMDxgkrSCRxasB9+cq1FimvZVqfJGUkw+qcrOIuwSfdAvIddpoQIb
	Afdz03QRnVv/YeXxPkF+fQU5Bsacvkob8E0xrDpK3fuoankRRIzcuAUOP1TXu3kSam/H7nYHD/1
	SvAzDe/KN4mPNCQcMS+NL9GR2feYQ/YW/KzXSQZPyBgQ==
X-Received: by 2002:a05:600d:8447:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-4891ff5efe1mr26450215e9.6.1776688952186;
        Mon, 20 Apr 2026 05:42:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm28007039f8f.4.2026.04.20.05.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 05:42:31 -0700 (PDT)
Message-ID: <5f495c4d-60b6-47c5-b84a-e1ad952f1c75@tuxon.dev>
Date: Mon, 20 Apr 2026 15:42:29 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko.dev review (Re: [PATCH v4 11/17] dmaengine: sh: rz-dmac:
 Refactor pause/resume code)
To: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-12-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260411114303.2814115-12-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10058-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:dkim,tuxon.dev:mid]
X-Rspamd-Queue-Id: 9261E42AE02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > commit c08d50f3400ecf3dbc032455be7a589baf899258
 > Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 > dmaengine: sh: rz-dmac: Refactor pause/resume code
 > This commit refactors the pause/resume support to use a bitmask for the
 > channel status. This prepares the driver for upcoming system suspend and
 > cyclic DMA support where multiple independent pause states might be active.
 > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 > > index 04eb1a7f1e627..d009b7607d447 100644
 > > --- a/drivers/dma/sh/rz-dmac.c
 > > +++ b/drivers/dma/sh/rz-dmac.c
 > [ ... ]
 > > +static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 > > +                                unsigned long clear_bitmask)
 > > +{
 > > +   int ret = 0;
 > > +   u32 val;
 > > +
 > > +   lockdep_assert_held(&channel->vc.lock);
 > > +
 > > +   /* Do not check CHSTAT_SUS but rely on HW capabilities. */
 > > +
 > > +   rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
 > > +   ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
 > > +                                  !(val & CHSTAT_SUS), 1, 1024, false,
 > > +                                  channel, CHSTAT, 1);
 > > +
 > > +   channel->status &= ~clear_bitmask;
 > > +
 > > +   return ret;
 > > +}
 > If multiple pause bits are set in channel->status, will this unconditionally
 > resume the hardware?
 > If a channel is paused explicitly by a dmaengine client using
 > RZ_DMAC_CHAN_STATUS_PAUSED, and is subsequently paused by the upcoming system
 > suspend functionality,

The upcomming system suspend functionality don't call rz_dmac_device_pause_set() 
if RZ_DMAC_CHAN_STATUS_PAUSED is set or the channel is not enabled(), it just 
return. The following could be checked:

static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
{
	lockdep_assert_held(&channel->vc.lock);

	/* Skip channels explicitly paused by consummers or disabled. */
	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
	    !rz_dmac_chan_is_enabled(channel))
		return 0;

	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
}


 > it appears this code will write CHCTRL_CLRSUS to the
 > hardware as soon as the first of those conditions is cleared.
 > This would silently override the other pause request, causing the hardware to
 > resume prematurely while another client expects it to be paused.
 > Should this update channel->status first, and only write CHCTRL_CLRSUS
 > to the hardware if no other pause bits remain active (channel->status == 0)?

