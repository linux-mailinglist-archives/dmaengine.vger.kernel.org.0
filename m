Return-Path: <dmaengine+bounces-9103-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHLkI0Bln2lRagQAu9opvQ
	(envelope-from <dmaengine+bounces-9103-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:10:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125419DA92
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A6AC3039089
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF030E84E;
	Wed, 25 Feb 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDHtosd3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC12ED848
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053812; cv=none; b=Jy4o7ST/ezwzvgc6jmX3873I9onVHj0DRsiist08FjvEvpW1ETYLGUmc4cisoSBhx7RTbT3uTJAuqcvtmE52vdZD9CWGReuwWi4nqywWiaThE2jWUwd5d1aiqoOen8xGTEhJfo+FfbzIZVIbo7r1Fmy8sSKncWoSe3kf8vvweVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053812; c=relaxed/simple;
	bh=06nmfwRvbc4SrM6YO+cZa0ldyWEh+tNkf/cH3HmS2VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P654CizPvtLmCcQeUO66qU0/m00UbtDo2BwXsnEfVHvdFJpB4pOJj02im2scUPxFg7XC4JczxO7KBGtmn+0fkCweu96Ld6DOz1VkYE/w42WsQEwlGc9TM64BYXLshy2ic/vL9fEXgNc61V3HhHZHTYJ3xMKZqtQzdzILkyWld8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDHtosd3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483abed83b6so1945225e9.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772053810; x=1772658610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/pY8Ws34EzD5RhJ2xU6Wdiag22vp0MppP+x+iDkBdY=;
        b=FDHtosd3/HChPZVEGz+tLwUlBtePknosdSlbzr6l46a9+wElDZUCqN0wY5B2LmM4LW
         lwft0wOdFB7u3kOSa6Rn0w3/zNvk9HMtZ/gEjwCJbOHpT/xPVJ8COi67xGfVecgefI2G
         PKOgft/TXXbg39nDmcmtTV3zeDZXScZejcQe9XgwxpouFN5cPObi2B3DA/lttAqOo1Oe
         PvCaJl0cM9LhY0aKZWfYX+TeASe9tQqG8f7NuYezUH44gqn46CDcax1xdu8jpVSfHkuV
         Dlz/aTx7MvXQa9MXANap3AvCAKS3yFImboIW8FZ+Ybl0dESVzsCBjg0ymriS117Dj+Tk
         OE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053810; x=1772658610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/pY8Ws34EzD5RhJ2xU6Wdiag22vp0MppP+x+iDkBdY=;
        b=A9+CYGCbzOiOfNDXhs8irVCyisM8OT9toNLNhT04+qX04c34ZS8XT4Ag4d/5/bV6gn
         XRzA3OCOjbB8ECDL2vZfS+ts44xkcJmNmhAsBsWpDHVqxj0S2AHNf3gPc/XZFV+aTE8X
         sEsDltoMZWuQnWXUKWzeE+UuOBTYJyajsYhagSKw91jITVfIUq5N1QXIsxMKEOY5+abd
         sPlQeucr51B80l9Yw+RQHpU3PCdWXUYb8lqYJvHdvV+4g5ys73b2s57wWyP2p633LN+n
         tHv6Jifel1XSyCx4P+3F0cU5rIYhU+NVCzEwje3pMl3AroluGwtGDDSC5CgXabwaS3T+
         cG4g==
X-Forwarded-Encrypted: i=1; AJvYcCUao84PYstJUjZX0/IWe03boBc/aG1uspipn2Tk9bt+q3eIFVSFkmF+G7gA+0qto94Nw29dy6pUMkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlssBPDTs58EmMApVZfloxZHOxwm9eABDXY1dhVy98O+47I9e
	YPNrcU3FQaJrFZ8M1Yt/5/xTTSF2tpA5hAXghfKYqfKOmcpyIwjw4sAJsTQlN9wf
X-Gm-Gg: ATEYQzwu0y8NrNPEjWfGk9a8symMFiG2/MNhGbkoBu2YCm1q1LJZIe48Nmtriz4nDFg
	FyN6IgMldHbeeuhqsiCIz1AHVk2sZ433AsOe/Byqv23D0SCGcO0s3zFINnbaRrMe4gUg48beKFp
	Jv2SvTvam6jFT1K4qxTsez1xhiNrFj1WTw61NhNMh5R4g+2CVGNGkeFVQBHb58DzqRmpOe3UkUC
	xrJSuyxez0WdIs4+l6aBySaXHYAhoBM+Z+C5YsvngFDMLTL4HwOrexdY0NfnHSIW75df9JbyUXq
	ys4tSFQ3+8N5ObrlS94liFVt7hlL7pdtE8MsnQU7SPf9RDfkosTqJJVzIM0L4VOvAxo6XAS9jsY
	NT852AqK/31jyKq13pCzbX1sk4sKd4D8tH14rvoj9PUUf++gFWNbPp6VO35NSk8qhDZE/aKUP6H
	MLYfrQlRF90pSOcU5kq0fi2BwbmYQ=
X-Received: by 2002:a05:600c:450c:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-483b80c9ea4mr157113195e9.31.1772053809437;
        Wed, 25 Feb 2026 13:10:09 -0800 (PST)
Received: from ideapad ([2a02:8070:a483:bca0:53b0:bd8b:cc43:555a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d5463dsm33238139f8f.34.2026.02.25.13.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:10:08 -0800 (PST)
Date: Wed, 25 Feb 2026 22:10:07 +0100
From: Alexander Gordeev <a.gordeev.box@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] dma: DMA slave device bringup tool
Message-ID: <aZ9lL6-Q07PryHqN@ideapad>
References: <20260221132248.17721-1-a.gordeev.box@gmail.com>
 <aZ4njFwdYsMLTcSa@lizhi-Precision-Tower-5810>
 <aZ7CwvrgPMkzMouW@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7CwvrgPMkzMouW@vaman>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9103-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agordeevbox@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	BLOCKLISTDE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:server fail,2a02:8070:a483:bca0:53b0:bd8b:cc43:555a:query timed out,100.90.174.1:query timed out,209.85.128.48:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7125419DA92
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:07:06PM +0530, Vinod Koul wrote:

Hi Vinod, Frank,

> > I am not sure if it can work for general dma engine because it slave setting
> > is tight coupling with FIFO settings and timing, some periphal require
> > start dma firstly, then enable DMA. some perphial require enable DMA first
> > then queue dma transfer.
> > 
> > burst len is also related with FIFO 's watermark settings.
> 
> Correct!
> 
> I like the idea but it is not practical. Every dmaengine is tied to the
> peripheral for setting up the transfer. It is not a memcpy! How did you
> test it, which controller was used ..?

I likely missing something, but how this differs from dmatest, which also
lacks any controller-specific setup?

I tested it on Avalon-MM Interface on Arria 10 FPGA and found it super-
useful - thus an attempt to share.

> ~Vinod

Thanks!

