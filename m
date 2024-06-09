Return-Path: <dmaengine+bounces-2331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF9901825
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377DE1C20C04
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 20:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7917942077;
	Sun,  9 Jun 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE2my+bV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CF1CAAD;
	Sun,  9 Jun 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717965409; cv=none; b=JTBur3xT2P7xBZ3VLzdrI9nopmA24o1MbkLbe0yzUnbPc2qANQBnDbG2njYSWlPuu/xvNbTonCPBatnoCB6JjZdZJjLxpdeSqMckcOfw+nu67/f+cMX+Pa8kNbM/uRSo7oLKtnjFM+VmnR4SluQvqcwL/4JOAmwC9SZhYWrlb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717965409; c=relaxed/simple;
	bh=uJwcxL7fTbZETpE3JIp5KC3v1ONtZCjWCBG3BxU4g58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbh/YqPKmoPlPR02tB63DEPm1QbPkxWAWXbEq7cT+DDaTy6dY6986DLHTYl5+Q2jc8pIdoKAlWp8NsqSxv0m1P05O5XhYvxfLiwoQdGRjllRhLp5Og+PZDtz+09AzNgxHEbB9HeP688WV761kvJhDkA/lSRyb++F1uxxdIQWE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE2my+bV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so22172045e9.1;
        Sun, 09 Jun 2024 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717965406; x=1718570206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWDOI6UMkgE1f+qKAKS/6XLS02d0j4d7NjNR9Xr9Yqg=;
        b=BE2my+bVoMWpV8CZgxBBOvZw6b0Vq5aLRIKU6w/ZS8ct05KPu88KNkC/Bc7AZx8eS1
         FoeadCGmEjemZJoFCT1ZM2lKn9ZOKvADA6yiB/oGi4Co+0Wr6qj9skWwX1+mh6m1NNFq
         yezNlRuKc9V0lgXenx+i0xrOi/CnuvPbzYYJxnfYOvXQusNxuVVTPS8/VzaJeF+kYBGK
         X7nKB63Cxo24e83X7tDEdTkuicmL79YF1qd2M2ZI/iAD0BNrth4J0e6Mmhuh0LqeBzKU
         fEvp0BE9xEG9oh4lMAAqnV4OmAczzmcdkQBFBDoctCkUV1T8X8PCi9OXC/pjm2p7H+/8
         bWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717965406; x=1718570206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWDOI6UMkgE1f+qKAKS/6XLS02d0j4d7NjNR9Xr9Yqg=;
        b=BZaEAlrR6x9aMpTkco1KNQUdDoWLkKMp8jck3qekTDVFIwLnHHHTQr+ui2fBGxmMOI
         wOJgf+kiA8mnu7DpU5IA81SN4z6nmtp2V49RcYuIhmuufNKlkS8hxgDL1+Hg/mIY+fZm
         fDKDUySfN7PVqNdStn7sB3B22G9B0w041sk61NThB0tYmP7LixXHVw+HhduGSGxsDblw
         X5diZUTrE1o4ghjH9NpaJVpu8Uz0+90k1HoKnW0GRFDgjG4d63RlIK8+1HnHLpa7uqiq
         sgbmnqXgx5BivXhbTq7ujO9MPMKnHLIvBX+LjE0RyXHWxsCdpLI/FaHhFvPafo6dLgkN
         AqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjaSq0EqqNww7NNw37KhnKCxMNwapAfPvuGYbhnzScu5wfnmIMflM2+YKgMcuUwhCG2YhDABR6qMTnK569PTjhYWyHak863H96qy/v
X-Gm-Message-State: AOJu0YxaimZHjSMOu7mAbimvj5ZA+6jix5oio1kUyqMSbtztUsJG8tIr
	E7ws7sLVmxMTNao0LmP9uxlAo7KG3uaeG/MpIsPOvRPwo6OIRn9c
X-Google-Smtp-Source: AGHT+IHbb4UNa5+vKV0xdC41wzn65JLyMWGJD+HoTgxYjP87QGgrIIMHuf/1+MtlzFHr6/sqQds0jg==
X-Received: by 2002:a05:600c:3ca7:b0:421:392b:7e13 with SMTP id 5b1f17b1804b1-4215acbf7a8mr109039515e9.4.1717965406025;
        Sun, 09 Jun 2024 13:36:46 -0700 (PDT)
Received: from olivier-manjaro (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421661ecda2sm91286865e9.2.2024.06.09.13.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:36:45 -0700 (PDT)
Date: Sun, 9 Jun 2024 22:36:44 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dmaengine@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Eric Schwarz <eas@sw-optimization.com>
Subject: Re: [PATCH v2 3/3] dmaengine: altera-msgdma: properly free
 descriptor in msgdma_free_descriptor
Message-ID: <ZmYSXMEN32kl2leH@olivier-manjaro>
References: <20240608213216.25087-3-olivierdautricourt@gmail.com>
 <6647d607-1424-4366-865c-069a166c61f1@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6647d607-1424-4366-865c-069a166c61f1@web.de>

On Sun, Jun 09, 2024 at 07:30:04PM +0200, Markus Elfring wrote:
> > Remove list_del call in msgdma_chan_desc_cleanup, this should be the role
> > of msgdma_free_descriptor. In consequence replace list_add_tail with
> > list_move_tail in msgdma_free_descriptor.
> …
> 
> Would you like to add the tag “Fixes”?

Right, the Fixes tag will target the first commit
introducing this driver (a85c6f1b2921)

Thanks,
Olivier

