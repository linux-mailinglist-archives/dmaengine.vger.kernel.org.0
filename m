Return-Path: <dmaengine+bounces-4781-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C9A727A8
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6A18923EB
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 00:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090121C36;
	Thu, 27 Mar 2025 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2SrKF+A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C50186A
	for <dmaengine@vger.kernel.org>; Thu, 27 Mar 2025 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033915; cv=none; b=I5YGKFVmOTuJHdUZxPENl3i1dOPDlpzVjUfK+FN0btsfn+xx/XZfXmnfveNolpVv7FnDw6qfoW52kMK3N/pWiNIXApCcL/qTdZr9xoUZ66ACLhK2hWqo5K0lrN6FOq+maNflioaCqQgoOlzp35mbQ9/CrNhRfx/w5J1wpE3mPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033915; c=relaxed/simple;
	bh=lJRw0bCPxfAU1UQl1vpzKzq75sgXTBkOohiiuAFwAM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ezf4Y3g0STmqkH8f+btlL7LDtay71CXNeqsXc0lbsDlZKiZWBQIdSV4FAWs4cxszOackkEBdY8nkMOIdDpXmPX+LSG4vYVy11AhiUrr1YPprf9bTjiyXVkHb4uI9DJjxLmKU+D1fONXLEDMHFgzdb8LO1zHYS5aDbKBYcAZp98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2SrKF+A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso31115315ad.0
        for <dmaengine@vger.kernel.org>; Wed, 26 Mar 2025 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743033914; x=1743638714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJRw0bCPxfAU1UQl1vpzKzq75sgXTBkOohiiuAFwAM0=;
        b=M2SrKF+A3Amy8mXDMGfKK0T1IPda0QOtAffIAzn/oHFOqzNupDpG0VUdGB8+tn9wtW
         D+kIKmUZ1bvDCa8u2H1/rkMsMKDh01fmRQNEM93fhjaYGg82XUuE9QUfrlstHPam+XLJ
         PMIcliIrFelg2+C3HANGocElViz5EvSX1hzIczk7i97AnWWt1gsi/5uFDZAfblqWH1hN
         WNKXvZQf3C9fUeHg813sqlhq//GP5DmjKYivSjGUWh6+xLvtRFbA1gOZ/RGFf7dgiBKA
         xCkv8dHtfcQHUd+/gRAwrj2HHDHKJSZAtWDR85b91n97hpam7Ozji45tw1EGQ5qNcRQO
         SfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743033914; x=1743638714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJRw0bCPxfAU1UQl1vpzKzq75sgXTBkOohiiuAFwAM0=;
        b=N9G9VrtvYjhHuwn9/zk/2wGfjgY2itSeFS32k025cFy6Muk6Is4bGBUwZySqtKHL4C
         uo4WsLJY8OeAWaNj5e7TNHlG9uH4DE87F/sixi7tmpTdbXHYUmmtqiTHt9xwJkgtDHrm
         SU+vbvyq0hFVhSRpNhVed/gPmCws5w20YkucM3F9igW4mMbBfB7gV5f86B5JPpgOnbD1
         eMyzj2214o0lvYZ591z00BL4aY+JJuj22arFZn3SLlu/Sb6+1CYmejnC39JzSSs8mke1
         Z9WHhhVoPM4/+474juWuuhzwYE4j8Koz2xoOp98MQtdmBL5UUMNS1v8Iat3xB0iErxHv
         5q9g==
X-Gm-Message-State: AOJu0Yzu5jQbt6qOZiSNv5DVCP9p5ltqkfnKScyBu7cY8Il7n+D89gZm
	P7TzgMKgqYqNKMe86eGjmioObgrlX/dWCCh/Ze93cM1wsx4v3Tw+KZuQvzMU
X-Gm-Gg: ASbGncvvlq6UICyC3dZJ+7vqCTHUQInm7aiB4FxLngr0RuOsR5XWn5P/7cDpfC/bGZG
	DxNKU4EYbylt9xXbyoW/EbnYQ51InAOnAe8aGfZwXGccr3h8O35xRfT1YaCcgBrp8ifTYXB8wGb
	arANFsVo5+PYu9sXyGMJwXbOhtK6T+hba7fEKeLlg0KRcSry30yzLt6H8Uz7+WL04Dj/UHuXGz8
	yNJZ47FglskR9dLr4h0oxlZQJ+foo5/+McrJjlr//o5mwDIsoiAn23L1axxrNJUYklMd0aNy+Nz
	52VYMiWnzsBK3/No5Ah+m+4UGgbaQ4jL8tGFNsGk0QjrBSZ6Lx6yL+3xezEGMpmJrkaCdJwlm5e
	++HlZEx7k8oI=
X-Google-Smtp-Source: AGHT+IG1f3nlHxrPYXDaAVx+I8584XJKvbCXNE4Fni6l7KzRSE+SWU5f6Ebn3BygFxegocsSN2OoQw==
X-Received: by 2002:a05:6a00:a03:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-7396030ba04mr2740020b3a.3.1743033913228;
        Wed, 26 Mar 2025 17:05:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e52:7:2557:8b15:e2f0:3710])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa39cdsm12798411b3a.25.2025.03.26.17.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 17:05:12 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:05:07 -0700
From: Kevin Krakauer <krakauer@google.com>
To: fenghua.yu@intel.com, dave.jiang@intel.com
Cc: dmaengine@vger.kernel.org
Subject: idxd: shared workqueues and dmaengine
Message-ID: <Z-SWM-F0O9XU1zqp@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey, I'm trying to use idxd inside the kernel via dmaengine. I'm
attempting to get shared work queues (SWQs) via dma_find_channel(),
which stubbornly returns NULL.

After a lot of printk-ing, I finally ran across DMA_PRIVATE. I also
found [1] and saw that DMA_PRIVATE is also set in the idxd driver since
c06e424be5f51844 ("dmaengine: idxd: set DMA channel to be private").

It seems like this forces use of dma_request_channel(). But I believe
the idea behind SWQs is that they don't have to be exclusively owned.

Is there a way to use SWQs via dma_find_channel()? dma_request_channel()
seems like overkill, as the point of SWQs is to not be exclusive. Also a
good chance I'm missing something basic here :)

Thanks!
Kevin

1 - https://lore.kernel.org/dmaengine/9714cb6c-8b37-4fc6-bb09-a1fb4a5bb1b8@intel.com/#R

