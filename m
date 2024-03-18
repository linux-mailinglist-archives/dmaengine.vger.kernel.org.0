Return-Path: <dmaengine+bounces-1424-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C187F131
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE17C283CA5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47131BDDB;
	Mon, 18 Mar 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwf9loNy"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1261862C
	for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794124; cv=none; b=Onb8ET7TykD2Yr4umw4fsW3VXg9fs4e/ZawYONAIBfiOR08yJbDjzcRf7EwEIVXkn/NomPaUaDhJrtzwECoLvSifcb0o/s3JK+BGafHa1UgEGfFB/3hE9AeWxO2AF3a541znDSGja+0n1j16Tp/6Ii7ndnQueToN/D2ueIWUE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794124; c=relaxed/simple;
	bh=Ehu2bwuC8Yv2pae7fnhUPxBnZDfT0UgVSnQviN83fpY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQh34rz3XdZ/ieMaH1CgCOHlw09hYdmVvYp3C3R5cmG2IiWvIQBWgBzXc/xJseBu4sLFK7Q8CUKBJwQHo8AB1VbTVnAmfxAz2p3aEYgrEuvbMAWs1IwjA4UzyRDVr3Q1RnG+8A+lZRRHgMp287tQubIC9pTRNUjoKe2CdMsN7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwf9loNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710794122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LujJinkcV/sClcNvSY7KKJ9gnJ5ir5AaJUjzJxPEBN4=;
	b=fwf9loNy96mnqtjEtZav6ZXD+BEidROM3ucZL1mKEpI+tIb5i1lz9sHp1gv4I36nilxQ5T
	qKYCqXHEd6hHtSa2xwVuc9ij1tKWEP0Ir7N+rL74zzgURF9hWPaUISHInBuLxDgcF8eZuI
	Hc2072jU2CdoqTPDMYiBAV9wv+YZqmY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-reSZ2SVNPCuhyoALSGOf-w-1; Mon, 18 Mar 2024 16:35:16 -0400
X-MC-Unique: reSZ2SVNPCuhyoALSGOf-w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-789e7db68e0so404452385a.0
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 13:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794116; x=1711398916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LujJinkcV/sClcNvSY7KKJ9gnJ5ir5AaJUjzJxPEBN4=;
        b=FM+/CRMEKpl7n9/HyXbWjceKS+FVtrpprSkbAWgctl7q00TlAdIOIAUzBiUJEja4Fv
         GvynonzSXiCBEETQYNvF3cD7HkyHyw0SnGrPE2yQY5toeF4j2SsM2r8Ql0W7DKWmLDHs
         o2sOD32ToIf8v/ojmFCm0KRbvKwER0BhZS63bqUYj70+QMFzMhmUNeRuCkPemmaUYLz3
         WNJzXdkNNxHqZcZH9zXEYXbZl7l627R99PKGhQCqLQYcsAyF2riUssZb5HxRKs/f2M5Q
         cn15vSQ+7G1NQ9JS36THvPXPHUU8ja8kWTVa9iCzbl2llE5xn1Ui8CwJGMrr8kdnYeLj
         G1lw==
X-Forwarded-Encrypted: i=1; AJvYcCWCYZZgm6FjdFebPcLsG7L0GltPoKT5S0RU/jF8Ya23Xv9z9O2UMzhAIOWwC/5d2hW4MQSBt0s5yQcMqIdOFswAn4QKrtMshbo/
X-Gm-Message-State: AOJu0Ywa5XCiQgrKWTtt03HsO+Hkh1FFA9pc9UbfbHHZnt+5r3PuGIF4
	iDGdToHWP/jV5HXD7vUq6PCexqI4BqtyNcMZFr00u2XINoqRGR/etZCfW19oKCO7z6WCg6fcNQR
	ktafHvJvLyb4TXRFemJU0tMXjyrU620mc6EJ5BRCof/hos4wd0rHYoVz57A==
X-Received: by 2002:a05:620a:1921:b0:789:f7d2:64ae with SMTP id bj33-20020a05620a192100b00789f7d264aemr6925440qkb.20.1710794116322;
        Mon, 18 Mar 2024 13:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDel9RtaTTNDuadPwMgCEtRQv/3zk4SCLxT0N5SFTYDz7P63jDG3TV3xaTnuSI18p38Ne0cA==
X-Received: by 2002:a05:620a:1921:b0:789:f7d2:64ae with SMTP id bj33-20020a05620a192100b00789f7d264aemr6925427qkb.20.1710794116068;
        Mon, 18 Mar 2024 13:35:16 -0700 (PDT)
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id vr17-20020a05620a55b100b00789ea5b08bcsm2798845qkn.23.2024.03.18.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:35:15 -0700 (PDT)
Date: Mon, 18 Mar 2024 13:35:13 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, dmaengine@vger.kernel.org
Subject: Re: Question about the recent idxd/iaa changes
Message-ID: <oqg5575kdaifbkftpg6rcp7koc572agsbuatkty63rosfl47hu@utiou35xdt4y>
References: <6jxxptlp44ipbafnbfi4ntyphd22eqj7j7grpwfsnvunuspkre@iolf6nbqfoxp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6jxxptlp44ipbafnbfi4ntyphd22eqj7j7grpwfsnvunuspkre@iolf6nbqfoxp>

On Mon, Mar 18, 2024 at 01:18:58AM -0700, Jerry Snitselaar wrote:
> With adding the support for loading external drivers like iaa,
> autoloading, and default configs, systems with IAA that are booted in
> legacy mode get a number of probe failing messages from the user
> driver for the iax wqs before it probes with the iaa_crypto
> driver. Should the name match check occur prior to checking if user
> pasid is enabled in idxd_user_drv_probe? On a GNR system this will
> generate over 100 log messages at boot like the following:
> 
> [   56.885504] user: probe of wq15.0 failed with error -95
> 
> Regards,
> Jerry
> 

Hi Tom,

A couple more iaa questions I had:

- Are you supposed to disable all iax workqueues/devices to
  reconfigure a workqueue? It seems perfectly happy to let you
  disable, reconfigure, and enable just one. I know for idxd in
  general the intent is to be able to disable, configure, and enable
  workqueues/devices as needed for different users. I'm wondering if
  that is the case for iaa as well since it talks about unloading and
  loading iaa_crypto for new configurations.


- Is there a reason that iaa_crypto needs to be reloaded beyond the
  compression algorithm registration? I tried moving the unregister
  into iaa_crypto_remove with a check that the iaa_devices list is
  empty, and it seemed to work, but I wasn't sure if there some other
  reason for it being in iaa_crypto_cleanup_module instead of
  iaa_crypto_remove similar to the register call in iaa_crypto_probe.


Regards,
Jerry


