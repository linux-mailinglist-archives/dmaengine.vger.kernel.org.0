Return-Path: <dmaengine+bounces-1433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E887F320
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 23:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DEB1F21EDC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937A5A4CC;
	Mon, 18 Mar 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7WMpyMu"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0925A4C9
	for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801282; cv=none; b=B1t4eZMl9+Dd9HQHs7RpgzIVZxlbtDvScWo1+OxgaIkcC4l3J6iuOZ+rFF1MO3heVb+1lDzx22U+FIHOTPDWWpe8lORhAP/ImNx5Lme569XwahApfpppCbVgGLZKW/HfliPgfNcGF/lXszuHZf2sG8eZUUCF/YVUurNGjK4dR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801282; c=relaxed/simple;
	bh=KAVVKtGv0Dflj+0iDbUsAiFvEfAuYzoGzmmLbUkoqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ane1RK/3sF8GntersxF6wMcgp1OJXmmAtzA2SmlMpbuVWKqPNK+eFFvfBVLZUqTxssHt76ziu99KwKH44e68WV5vlKSdwnsNYPPJZ8XB/vop9S0OtArM/t1bmR90hzriXsQdw7zc6eVNxDT/2ojVxF2jFUYsYFjoTEGDvyABgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7WMpyMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710801279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jXlSBIlF4PVmUNb+okDw4AvjuoKV2r08ixisfQWS6w=;
	b=G7WMpyMufp8+wtUoNlagmo0nfO9kURhZK2JcghxFVDPDyPi2SGsmip+MlHYKvVU7PeSfx9
	4WUq9Sgwagv1lNx3d+sIURxmCmPZ7cPDMcoEd1g7hhesCNn/y894maB5Lnxl4BntK+ljNK
	CF8t7Z6hQjkO3gYNuwnBcAmjBZLdI1M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-L9pf_RK7PsepToOtfnVN3A-1; Mon, 18 Mar 2024 18:34:37 -0400
X-MC-Unique: L9pf_RK7PsepToOtfnVN3A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-789e79ca3a6so353092985a.0
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 15:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801277; x=1711406077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jXlSBIlF4PVmUNb+okDw4AvjuoKV2r08ixisfQWS6w=;
        b=QFJSe7NB09L8yjdTUyHbOLFCtnfwjFdDfFU+mOcsp6WuAx6GN3pZZKsLIvTKWI3Bed
         dzwCDadfzsR5qHXwi9mcIvedbZ9vm+WsZFLYXm6FYDcQZBWRuHlwugKqZCPcNL4LG5GE
         ajOAeejYx2s4V2Fs68kSh0rkjSfUC0Oz8J4QeXGSHqIcCjQRT54cfKL8SQGkBavC+cIl
         t/7/8J1IizwWKG0WFwJJ9CytXi6A1rzDZNBA6uV9dQfuhZac6xwloUivdY+uzZCxmogZ
         zEyjuMtYJ6FBKLMrUQnzbECJH9RYuz35ZBX85A+yId8ImERQXIs7/cG4DecN6wBF7ZmX
         cqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfulUmd3oKjpEONqg8HOfJQwh1EGLcTekG6+JvODWB7bwMFK2ZGDa6ZsIM9TtbF2PZUOR3hfw+yl/QJ87VX2BuRdr02c0I1G+h
X-Gm-Message-State: AOJu0Yx+EW9IiV0kIkaYASMu1PCGMhziw2JHoFH9HMNObVCH8TUXoamN
	BpMGJsxgx3/cx6tNtghvpIhgh4VclEQtngsQ69ShGF4/fB9I2nRP3HqUDHqYwma2X0+VQJRtj3S
	+vO0BVx9DB/0OVv4/ckH5V0id/dRmfz3tOvo00uyudpmJXtkNS4qKAzrI0Q==
X-Received: by 2002:a05:620a:4088:b0:789:e926:e011 with SMTP id f8-20020a05620a408800b00789e926e011mr1271903qko.9.1710801277347;
        Mon, 18 Mar 2024 15:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHweuIRI23cSHeG74OXrXJnFw+5b+ABImqZCPu3ACDGJg3h2Tgq1/VWrSq2/OaAJzWA2e/gCw==
X-Received: by 2002:a05:620a:4088:b0:789:e926:e011 with SMTP id f8-20020a05620a408800b00789e926e011mr1271887qko.9.1710801277053;
        Mon, 18 Mar 2024 15:34:37 -0700 (PDT)
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a441500b0078a0df3489esm414765qkp.116.2024.03.18.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:34:36 -0700 (PDT)
Date: Mon, 18 Mar 2024 15:34:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	dmaengine@vger.kernel.org
Subject: Re: Question about the recent idxd/iaa changes
Message-ID: <7rrvqwcvuzvygnbow2wvzolvp5bq5dgaytk24filf3uyz47tv7@dvvj4y6tz6xb>
References: <6jxxptlp44ipbafnbfi4ntyphd22eqj7j7grpwfsnvunuspkre@iolf6nbqfoxp>
 <oqg5575kdaifbkftpg6rcp7koc572agsbuatkty63rosfl47hu@utiou35xdt4y>
 <f653d44ae2a955b021eea2acb7616321d8e0cff7.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f653d44ae2a955b021eea2acb7616321d8e0cff7.camel@linux.intel.com>

On Mon, Mar 18, 2024 at 04:57:52PM -0500, Tom Zanussi wrote:
> Hi Jerry,
> 
> On Mon, 2024-03-18 at 13:35 -0700, Jerry Snitselaar wrote:
> > On Mon, Mar 18, 2024 at 01:18:58AM -0700, Jerry Snitselaar wrote:
> > > With adding the support for loading external drivers like iaa,
> > > autoloading, and default configs, systems with IAA that are booted
> > > in
> > > legacy mode get a number of probe failing messages from the user
> > > driver for the iax wqs before it probes with the iaa_crypto
> > > driver. Should the name match check occur prior to checking if user
> > > pasid is enabled in idxd_user_drv_probe? On a GNR system this will
> > > generate over 100 log messages at boot like the following:
> > > 
> > > [   56.885504] user: probe of wq15.0 failed with error -95
> > > 
> > > Regards,
> > > Jerry
> > > 
> > 
> > Hi Tom,
> > 
> > A couple more iaa questions I had:
> > 
> > - Are you supposed to disable all iax workqueues/devices to
> >   reconfigure a workqueue? It seems perfectly happy to let you
> >   disable, reconfigure, and enable just one. I know for idxd in
> >   general the intent is to be able to disable, configure, and enable
> >   workqueues/devices as needed for different users. I'm wondering if
> >   that is the case for iaa as well since it talks about unloading and
> >   loading iaa_crypto for new configurations.
> > 
> 
> In general the idea is that you set up your workqueues/devices, which
> registers the iaa-crypto algorithm and makes it available as a plugin
> to e.g. zswap. The register happens on the probe of the first wq,
> subsequent wqs are added after that and rebalance the wq table, so
> yeah,  you can also reconfigure wqs in the same way.
> 
> But you can't remove and reconfigure everything and re-register the
> algorithm, see below.
> 
> > 
> > - Is there a reason that iaa_crypto needs to be reloaded beyond the
> >   compression algorithm registration? I tried moving the unregister
> >   into iaa_crypto_remove with a check that the iaa_devices list is
> >   empty, and it seemed to work, but I wasn't sure if there some other
> >   reason for it being in iaa_crypto_cleanup_module instead of
> >   iaa_crypto_remove similar to the register call in iaa_crypto_probe.
> > 
> 
> The requirement to only allow the algorithm to be unregistered on
> module unload came from the crypto maintainer during review [1].
> 
> Specifically, this part:
> 
>   1) Never unregister your crypto algorithms, even after the last
>   piece of hardware has been unplugged.  The algorithms should only
>   be unregistered (if they have been registered through the first
>   successful probe call) in the module unload function.
> 
> hth,
> 
> Tom
> 
> 
> [1] https://lore.kernel.org/lkml/ZC58JggIXgpJ1tpD@gondor.apana.org.au/
> 
> 

Thank you for the explanation and information Tom.

Regards,
Jerry


> 
> 
> 
> > Regards,
> > Jerry
> > 
> 


