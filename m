Return-Path: <dmaengine+bounces-1412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7287E4DD
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 09:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3403B1F21045
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F923775;
	Mon, 18 Mar 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKrdJXpq"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1F3214
	for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749948; cv=none; b=AAS+wMZ1r3I2ak3bSdP4MRqJR5fu363xhkAJHld9KaL0YELy/SZ/lvzACKWzpI0oeDX3OE6rh2ecUS9IxBxV6wcRVXk//uRGAZxg8q9wSqEGzgxmv42NMwhUyP+svW5Qst9Uz6yRO9RFfvfO6CsYKcF6V/npHZdaWfAyEFjCr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749948; c=relaxed/simple;
	bh=VQybKWu6DNzSmTQmon7Re63RneHGaVwatG2qfKPZU98=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZnaL9tr3Hm4luCreHB+U+CrB61YhC2IGsFVFR9Sw6FA02dyTvYKfdJZiFkAJnRZO4Hyalwj7rkm/HBDmBO7WZvY34S4ky2SSDrY3JxbhOMrZrcFG+xcB7XOTu4FBnb0y2w5taM2b58qiS75y8o4ud09/beK9O7wuHgYgUnIuNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKrdJXpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710749946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=h4e/Huijj4MEn5C7/UhFd5W1OLYdk6Wee5WodWB8tQo=;
	b=hKrdJXpqGpRrnQFpl7i+9KIuKsxNwSxHNtGnLzo1Gze1g3el/VzTNtXVVELKYomHOQ7dNk
	viMgZs8WNhDUyNoCV9hTfjAUXxC+zl+L9U6zKoJV7ByBnGvF0DJzFLwA5/QhBeYNBsVewX
	XCFWML2CbgQjkqL6qnUO/XsIVmbEnCQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-aeFGjbFiNbmhj3u919FBTQ-1; Mon, 18 Mar 2024 04:19:01 -0400
X-MC-Unique: aeFGjbFiNbmhj3u919FBTQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e68c647f5dso1050350a34.0
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 01:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749941; x=1711354741;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4e/Huijj4MEn5C7/UhFd5W1OLYdk6Wee5WodWB8tQo=;
        b=QT/xJ+RKBd0drO6o9HXZ2nlE7xWjCPB+LRnBtn5g9WbDhfEiPS0prE8G/u+PFihgFO
         YW2LnoBJAgt9MoD91B/ecE6EkaRHOS3Ghty5pOtLhyR/ni0u2JAxWG4df44/bBMrYTzd
         T0jy3iODuE9Vti8ColDgYG2qWScQqIztgDw0c495lj0xuW+6mfh4Ol5ePxWqninWqQos
         JPLlc1wA21iQ84E5NySZg4vmHY+TfDE4OqVzhBSNka0Ffi9DYe0U/XI9MMr6kvVq2GU8
         qJ3kqzCqGh2K+YvH4PlteIfSGUQ+ZdUd/y0YTTWTr34ZFmz181PvHfKD9llr9Yd2RwNx
         ++hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwt3iTk92q+LBSNOuq8HXV10wfcyxinF9fMOQY2lBtJMKd8K3m6hOdvNt2CWorXBtSkV8b0jyBxlUzfD73r/JR5lOLCBadDrbb
X-Gm-Message-State: AOJu0YwaZqyi+nytJzGrUkFeIKR8XSTLIefD19QXlFeoOzJIykcdn2Gi
	ELAmzzPpHFNtX65w9j2NFhYTXShyaTh6tVlLrZCXfcIbaiG+QnIaXetN6DCa+6xxlZ6lqHN09yw
	LAtRqKOX/QLwWBfVDx2il4e637jgVEu2PYloN1Fhc7q/wjgBdAbVLRbEhmA==
X-Received: by 2002:a05:6830:2097:b0:6e6:996b:cd3f with SMTP id y23-20020a056830209700b006e6996bcd3fmr404192otq.6.1710749941016;
        Mon, 18 Mar 2024 01:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2O26Jcw9ZWmsVW1sDUPWOucdpIYukZ8nWqthYkGZC/pRRJ1aPyV1Ww4boEdZTFF26wj/VJA==
X-Received: by 2002:a05:6830:2097:b0:6e6:996b:cd3f with SMTP id y23-20020a056830209700b006e6996bcd3fmr404184otq.6.1710749940774;
        Mon, 18 Mar 2024 01:19:00 -0700 (PDT)
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b006915face0easm4851289qvo.70.2024.03.18.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:18:59 -0700 (PDT)
Date: Mon, 18 Mar 2024 01:18:58 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, dmaengine@vger.kernel.org
Subject: Question about the recent idxd/iaa changes
Message-ID: <6jxxptlp44ipbafnbfi4ntyphd22eqj7j7grpwfsnvunuspkre@iolf6nbqfoxp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With adding the support for loading external drivers like iaa,
autoloading, and default configs, systems with IAA that are booted in
legacy mode get a number of probe failing messages from the user
driver for the iax wqs before it probes with the iaa_crypto
driver. Should the name match check occur prior to checking if user
pasid is enabled in idxd_user_drv_probe? On a GNR system this will
generate over 100 log messages at boot like the following:

[   56.885504] user: probe of wq15.0 failed with error -95

Regards,
Jerry


