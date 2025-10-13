Return-Path: <dmaengine+bounces-6824-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87022BD5CDC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 20:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BB3AE017
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B42D8371;
	Mon, 13 Oct 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgA0bG64"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2A2D8363
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381810; cv=none; b=rMHu0FSz2MJzH7znUUuwluSiCjGDCOYezHDA4hRDLB/ubH3JkTstIFkm/c5BwRpwdq5+1IesPJjVyef84Ye/eD0oud2I5cU4J05QaHe2RRh355D8ek5ofyTxVFADnimlCsmZdDPTG7brW5ict/x5zvxCzcCzUotbfoF3rP23oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381810; c=relaxed/simple;
	bh=BPXQKYM/Bl3lXPIDhXdBBlg948y7qQGSlqXVphTncFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6fGktxYmsY6VdVvbhM4u9zpg3RCeDcDCfm0zgrQQnC0J/QH8m2UOJfKzL7L/MYtKp4/4oOUgheIjYBhnQ6o9haoIAkisltFtUvgH6lPl+wpZYc/MNnbyB80Rk2IBBHCx57wPIKk26+JnoZDiU+HEyfsCXbZudZ2nqBObNSB1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgA0bG64; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2668807f8f.3
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760381807; x=1760986607; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PdPqTzdF7SvDyD8IZhblvwhbzmwKXRkjyRcByHgouQ=;
        b=KgA0bG64DZz2UQCSAcRM3i4EkJ1EMTlKPtV7tPyzmkExbl/0hEDRTdL7ru31BYV3co
         waObbuHfxYlgx4xZqJev1b9KvpCzoWwC4tPQy/UKMMUwbq1Nufk2cnwDEK8q2poEgXev
         ANHg9otFk14zLXHIulUYeuCmohoUiVl5gLgxaBj4zQmcaDGToQvzhz3eNvPlWyf0DS7j
         ZbDQNhpxSwaPo5sitdsyiRpR8wnSaiCSukLz0WOWwxn7+KBq/aEovDFXOLeYdn51JE8D
         v27ypaA+JEF2vyPF2K4hhbH6z32FVMvMW1BK5dgru9g2flflopUf5E6q3xlGCO+INV+6
         ye8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381807; x=1760986607;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PdPqTzdF7SvDyD8IZhblvwhbzmwKXRkjyRcByHgouQ=;
        b=DWqbjHBRD+UZu/EPy4xOIHsUlwOtFGXxuHkuQnL5zQoVnz6HEWH7FFmbwEUdkGMWDj
         vHWJi5CoKxEG2xe0J/uCsB4DFFb35v8gip/kDXrnqo4BZc+1524+fxUWZKjsygrmqvFl
         xwcRzlzsRM9GhyrUUEE7Cmd7BXbrqubsBk6gvuXPIrbeqnuLnStV9F4DLjO9NiBDeHDn
         hJm0BwkmmOtHQ4IBzbpoIoBIW+GnSnZqlBkpUVGHgejssNtwFNeEy42PYnQd1ri2e+Q3
         zwuWzFhvqqe3L+xFdazqKJBXPM71QEveWVDOD3LxtYQIqu5ORj8fQlxT91cc3o0aLztK
         dqqw==
X-Forwarded-Encrypted: i=1; AJvYcCXUH9RR2LJy3gkKzaLeikXFBMhvGYkh1ycg3mu4rQXmv+DM+joa5ueGZ1tVGPwDj0GyBpJYZ63TSFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAHd4yM2MUmuXrrORcooqn3/VBD0Te4GX90sI6gJDd/t5H7tj
	q/QvSV7z69UqODQOCXz/qcJ4khPjA2RafG4Gd/f5pNGkdHRqLFWXdjc5
X-Gm-Gg: ASbGnct6HNN33Kh6eDnOAY2HXuXb9k/0x4Uqo8GzcxaSRPph6JXWunbs3oMWe7AETqc
	ECaJm1G/Hu9BlqhWJY75UgxKIKPOpi89BLx/MhRDAsvsIosQTqfxvW8JR53jjE4H0Lpprf8kBkj
	sWTo9PqWwKT5J2ee20xj+jO6IOZMzND9Ji2sZGKHL8sP1Rk7VJ1TO1ci2HwtN/cxtkAAzI8Dvhc
	aB//bJwe3qmWFqOvzxYonRGBa/iFAP9gXHyI/8YETFFHsxTBr2MsH6TeXQlaXkUQVhRkvXRyzaY
	Mjz2LgFPaWSRuWUpmSCxGfylzFfL9l0Ccn6m6yTLyb7N/0cFExFm9GrVZvh6oUj1RL0EcLPF85k
	EvsCaJeh2e3QqDXa3VOq5Q0lCTJNgbb8GjjVWZa8a+ueIboQl2VbMufYnq5UZjzzSJk8x3A0BuV
	m2U9okexe55mw=
X-Google-Smtp-Source: AGHT+IHai3Mls23wDtQjYqU+yA8Bnt/Z79B4F1zs18pyxM/Jfa95xJJVJk8x/0DLk0Rp7CvMuxbr5w==
X-Received: by 2002:a05:6000:1845:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-4266e7dffccmr14069380f8f.35.1760381806685;
        Mon, 13 Oct 2025 11:56:46 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm4879612f8f.38.2025.10.13.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:56:46 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:56:45 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Nathan Lynch <nathan.lynch@amd.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Which amd cpu families support ptdma and ae4dma?
Message-ID: <20251013185645.yhrtn64mwpfom7ut@wrangler>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I have a dual AMD EPYC 9224 on a Gigabyte MZ73-LM0 server motherboard. I
am trying to use ptdma or ae4dma to prototype a memory management
related patch, but it doesn't seem like any of those engines exist on my
CPU. I loaded ae4dma but /sys/class/dma and /sys/kernel/debug/dmaengine
are empty and I can't see anyting on dmsg.

I cannot find any documentation whatsover online on those engines.

Could you please tell me which classes of amd cpus support those
engines? Is there a chance I have it, but I'm missing something?

I am on Linux v6.17. I also tried to check with lspci. It doesn't seem
to report anything related to ptdma or ae4dma.

Any info will be much appreciated!

Thanks

-- 
~karim

