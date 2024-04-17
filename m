Return-Path: <dmaengine+bounces-1873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274458A8A46
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AA21F214BA
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519B17278D;
	Wed, 17 Apr 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETV0RPBl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9A171652;
	Wed, 17 Apr 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375278; cv=none; b=jPyqJGQdqD1hwpSBqo/ef85MngJs5uRq3gO/6bRI29dREPtiJqU3N80+Q4vRlfkbqZ6fYxbgOabHOuOWW5pwTScWJG0zErKKueIX1Sci2gpZVaqIsb7yeUCPlF2NoX1Fqxtd5m76OmYA0bDMmV3GiST4YV5vfYuLwRJxG9bBbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375278; c=relaxed/simple;
	bh=XfHzgB4aV2c2xogWzTJErKZmSE4a6ue+O1xWmE0FhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF+nd+KIK/jeiL6Qp72DbMAsIL9q0bIRhlG04PQ+jUTxlS/w+rrF5kABqVdD+zsPfcDqMm+6j0O9b3e0g6/Y+cx7n3g0mCz5v+d3d+qwD5xGxaOrlCFxopBIuCwAtbntALN7nQsRGc4PQ+YdSkKZ8QlYS9M/trGHfSMnBNOUxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETV0RPBl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d6c1e238so7027890e87.2;
        Wed, 17 Apr 2024 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713375275; x=1713980075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hs0t80Ylxr9QEqkvd5Kr8l23QMRIrkw6TN/31dt0qBY=;
        b=ETV0RPBlOe4B5ydcCJMdCu7D6OAO/zyfXQISRDj6YHutcRziJEHJd8TlxGmIWpeyth
         k9M/omzKvRKgPO3EKa4nQP23D6OtD0kOg3PFBsvRNfJ7AdKAoZrbxeZCm5idz6dNIAcD
         lljsFFw5RovbJiT2EevoLSAxs2IisnKml/b4dml2ZqjDS6wqcyYjjP54xvEu4iLYziaZ
         3yx4Y9hb3QnHmdtfyNKpcgzm3ntVCQHqKtLILZLJiXHQ2vjHMIkM4t1wHC0jtCPBOsca
         n9JGQIKbQLJj72VwnflLPoOBYlI+5NO6QnMMsWl/T00nz1DXTq9pJyYtzxOCDDE8bsei
         QK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375275; x=1713980075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs0t80Ylxr9QEqkvd5Kr8l23QMRIrkw6TN/31dt0qBY=;
        b=NNvPn0CPP5V7olb7pSJXejvhoUXqMc06vsjCx6PeeUh80DX5wgVOqYi+aGdtsvqNkp
         ZfytX2DYpGe9aI1KERYRcG54AFmXyepZGVex3WvUugOLlQaL0RLKQEdJpCCp75Hck0AK
         xkbbYCj9juuM8ztOiOy5+GUGz1MlbU1ZSd1IYls273CYZit+Gn4uu3ShjLmUMJImeX34
         GP/lZVaW7hD80rBtsAzCnQmYwFPRfmdA/V2p46PIbM6qn1i345q9URXJLg2AvA/vS0qb
         iI07NSjbatsrRGjgwCWouZ+c2luY5bLakJ2IHqubue1aDs8rG8EKIG7/uw+MCSj1W03T
         1CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Ho2WZStPoZEZehoPmBMVlmOLNJtP4kwyrBBNXDNt9nRRp5sIPGTCs3PUP34dhzyBdIRa7qNYD6GliiHE3flvZ+4VicUYwq3efcoFGBpi9vtNfX2ItxYE6IIilE9v+TggO1de7A2y+qR2vBXipbkwMCdGpfyaEcckslm+5maZjQyOH3h5
X-Gm-Message-State: AOJu0YwLKtR4suSCWIvbxTPQG7O4a3+FKz5VnYvE5lt93OMwtK17Lufd
	k7+qWUKF4Q9sf6WPTnwQ1nfuuTin1M3Jrrx8Vbvn2XxLfR+L+xv7lxxZVg==
X-Google-Smtp-Source: AGHT+IHHGcyPKrDlBcJqMz0q5wVt3zmj7kBgGouBDKCRFQq22uDlPJM1XrHVcX4VmNzd2hOHkt8osA==
X-Received: by 2002:a05:6512:3da2:b0:516:a13e:d775 with SMTP id k34-20020a0565123da200b00516a13ed775mr13113311lfv.2.1713375274722;
        Wed, 17 Apr 2024 10:34:34 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e15-20020ac24e0f000000b00518ac6f0a31sm1413695lfr.18.2024.04.17.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:34:33 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:34:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: dw: Fix src/dst addr width misconfig
Message-ID: <mrwbfrfzwklavzdaups633wtnen3fyvrpmmdrrcvvsxz3tsjaw@xxvvbycjgbuy>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <Zh7N0-D-TJ1OXqli@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh7N0-D-TJ1OXqli@smile.fi.intel.com>

On Tue, Apr 16, 2024 at 10:13:23PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 07:28:54PM +0300, Serge Semin wrote:
> > The main goal of this series is to fix the data disappearance in case of
> > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > portion of the data received when the pre-initialized DEV_TO_MEM
> > DMA-transfer is paused and then disabled. The data just hangs up in the
> > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > suspension (see the second commit log for details). On a way to find the
> > denoted problem fix it was discovered that the driver doesn't verify the
> > peripheral device address width specified by a client driver, which in its
> > turn if unsupported or undefined value passed may cause DMA-transfer being
> > misconfigured. It's fixed in the first patch of the series.
> > 
> > In addition to that two cleanup patch follow the fixes described above in
> > order to make the DWC-engine configuration procedure more coherent. First
> > one simplifies the CTL_LO register setup methods. Second one simplifies
> > the max-burst calculation procedure and unifies it with the rest of the
> > verification methods. Please see the patches log for more details.
> 
> Thank you for this.

> I have looked into all of them and most worrying (relatively to the rest) to me
> is the second patch that does some tricks.

That's a crucial patch for which the series has been intended. The
rest of the patches were created to align the code around the fix.

> The rest are the cosmetics that can
> be easily addressed.

Right. I'll have a look at the rest of your comments shortly.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

