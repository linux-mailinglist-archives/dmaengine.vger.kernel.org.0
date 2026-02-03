Return-Path: <dmaengine+bounces-8676-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNliDXOQgWl/HAMAu9opvQ
	(envelope-from <dmaengine+bounces-8676-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:06:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5ED4F99
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86839304C620
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E636A016;
	Tue,  3 Feb 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBfWa63n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EA2581
	for <dmaengine@vger.kernel.org>; Tue,  3 Feb 2026 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098644; cv=none; b=rb8VzmHwjIz0TTx46uAhEAJuukNy0qz+Yc04sE7fMYPjs4wIEQ17Or0nrtG2xKfRdY75oWdn9GDkuNshL4P/HksE05I9Sw809xdLbrJFy/K/1702B/ZjN6QhRr0u1QS076qkhoV1L+1T9hVa6CpqfbIIQqGx1nwLkPa3aztuRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098644; c=relaxed/simple;
	bh=FUixnOUzsnewVHIstGSR0UNau6bECqfvDmklc77Vz3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmPYIDcm2XeYI1ssLeNT5SZ3qUGxjBzKa5woinsFzfUFRq41rgA4MEGFESSlTDCRUSSIeR9oOACgOu9fNpK0OvL5ycEKmnfDsQ8wZ6co4UvuPuB4y+eKr7zeEIFC7/hAVwBZrKnVGK4W02aBgGVTvboJKScxygIcHD7yZ22aQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBfWa63n; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b76844f89so4969229e87.1
        for <dmaengine@vger.kernel.org>; Mon, 02 Feb 2026 22:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770098641; x=1770703441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pn2t+jQqwxoi1mJ80RFtFYUwPK3JAB4g8JQHBr3tTk=;
        b=eBfWa63n3Jd0tOFfq28YON/U+S/EFVxYBoyMYX4XpoYxxwZbBfbfG3l8i6u0vir/RM
         rxltcpPbnvoOBMIxBvotKeUVHTS3ds54Go4UXRaBBoRoZeY+5q26DRUoSRI+IkJ+1N3V
         /Udj+wMzk5K4qCqChGSQGtuq8Muoh4a0L4+VznaVLYdqQLclGmq3Pfj1G9CS+YWM3oqI
         /V+uJ3daMJQYb16EXjG3SbpkUcylX3m7xv1wwnmuNEz2VkyAe3ksrVKEKKEhQ9vh9Yr2
         E/u++eX9BqyT6OtSsVPyVF0chd1crZV9lhlBY9FelpK9vPVs+d9F2/Bvzo9TT1ucHd/t
         WYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770098641; x=1770703441;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pn2t+jQqwxoi1mJ80RFtFYUwPK3JAB4g8JQHBr3tTk=;
        b=iAE1VrODXWg59ONxl4CsHMnrmbzVXlJfLtZ9uxaI9hl7n9wIGhjYSezgFwrBaj9v4L
         n2RCugplZeVfeVXhHAUFu+xzXNs8O0HvOmknF6v3TnPwK0997BOEkiBuBMT2ATCAi7Ba
         lUEGoPDsF8QIqLpUkivMbaX4ghjd8oMf8DJcMPzUC31V2YV/VU9+nq6MLZnlTAqHqCBm
         D0m9JrirTq/Dh1N9Mi9yBa8Ws9HRgXXYZK7V65SfO/llAM65UeIHuUf6ymosBniynu3c
         K0svqvQx+gyASp62BWFWZt98xzGiAPgeOCCJWxfjUcJGvwo+uwU25TirKCuj9vX8CLxG
         gdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIDSMA+MQX6+VjYJAxHkb+OTaIjZFr451Nule9+1Ugh01+5wBbe0fzXGcwU+/B1BWUazE4mabSLsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj626LgsN3nRFaHsM45y7Ylrd0KgbzFlNKCUtHYCDdw7sYvZcr
	IlAvV4wlh3pDkx70P0WpHuWKzqX0fIMjBcC8t96QOHJjaYQV7W23swUC
X-Gm-Gg: AZuq6aIhlvt+tcJqgfwIyzPZ22neTvsoS2GMx+VIcDwZgKQpticZjI9LvDdvoo4+ACE
	/XPPqey7r4vf5R+c6S2DFl6WYF+U5ou0uQna8JgcsF008PCAQa2ytN3LxkSWl2leAmUGiqqvEU7
	3WwkQyHMQNp+jD4dHP2AfIw8P9SIBkCTFy6HULEuUC1tnZY/zPmWytqdMCKLRWFS/geO3rCwF5g
	9R/afn7B30Ivg/JvXcqV4TknybKCwqyRa0BsRdYh7VPPpzOKmHdvbqCVl5sgNNbvfb+NE0dJnJj
	CC5IagbQ+iAluf1iKVaCdOKvxM4zOmgnDJdDaNsSeeH4hi8sKV4rFc01tR2dyvgzvXq2tbFGpmB
	uwpmvf3pNjyNK52QwZUMPWkOgQzfIKwpGsBDTZ7hOv2zOep+l7sJ9fhGyzL77B8jM7v+ZXuXG9r
	eQsRT/ncZVYJ/j86ReTFJvyBbOXSTuiJpbVXKbVvcyTAk/s2lDyyG+wYzerSXrmTPUV4xWgg==
X-Received: by 2002:a05:6512:3185:b0:59d:dcd9:73ac with SMTP id 2adb3069b0e04-59e16433759mr4731144e87.42.1770098640480;
        Mon, 02 Feb 2026 22:04:00 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e0772d926sm3850762e87.13.2026.02.02.22.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:03:59 -0800 (PST)
Message-ID: <e1817e62-5a1f-484d-aace-638f44f2bcb5@gmail.com>
Date: Tue, 3 Feb 2026 08:05:11 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] drivers: soc: ti: k3-ringacc: handle absence of
 tisci
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com
Cc: r-sharma3@ti.com, gehariprasath@ti.com
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-12-s-adivi@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20260130110159.359501-12-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8676-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterujfalusi@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 77E5ED4F99
X-Rspamd-Action: no action



On 30/01/2026 13:01, Sai Sree Kartheek Adivi wrote:
> Handle absence of tisci with direct register writes. This will support
> platforms that do not have tisci firmware like AM62L.
> 
> Remove TI_SCI_INTA_IRQCHIP dependency for TI_K3_RINGACC in Kconfig as
> it is required conditionally (only for devices that has TI_SCI).
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/soc/ti/Kconfig            |   1 -
>  drivers/soc/ti/k3-ringacc.c       | 188 ++++++++++++++++++++++++++----
>  include/linux/soc/ti/k3-ringacc.h |  17 +++
>  3 files changed, 181 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 163aadd589d3a..5499c0def527a 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -53,7 +53,6 @@ config WKUP_M3_IPC
>  config TI_K3_RINGACC
>  	tristate "K3 Ring accelerator Sub System"
>  	depends on ARCH_K3 || COMPILE_TEST
> -	depends on TI_SCI_INTA_IRQCHIP

I guess (based on robot report) that the selects from
TI_SCI_INTA_IRQCHIP and TI_SCI_INTA_MSI_DOMAIN are needed to be added here

-- 
Péter


