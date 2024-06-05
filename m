Return-Path: <dmaengine+bounces-2262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304518FC891
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254551C20935
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2296CDAB;
	Wed,  5 Jun 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="dvHxNi+1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06551257B
	for <dmaengine@vger.kernel.org>; Wed,  5 Jun 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581755; cv=none; b=lYGsB66qYkFxR79pf/qSDCY/wFgvOaPDMi8U/G6atEJfO/R15UwhiJbsL2qIWv//R4/3DGF6nd4/YHk+yGdS8FLCBkS5RU/fQoWedY3gLpkI0jQQf29QN9CSRJYFLE/ERdp+UOBRoYzXVzEpLkvaPC33gHtItUF3G7jSeRHrodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581755; c=relaxed/simple;
	bh=e68/NcnHETGGWa36M8Ypo4PZFH92J+rfyhXrxUhSS7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YfycqYs58f2uPqfCS9AEtyojIs3G1ChoHPyXBXhleJ1Lb61xvjTwl5tssp3wUr68qj1uMrpW8KC1/VMZRU5WIygKM6j9XxKH55NwwyzfseK2aY77/jQYjxC9rGl89NfYGOQO6POYhlmKmJWau9iDM7qqnGTqBlt44fSwQiO/X6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=dvHxNi+1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35e83828738so942052f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Jun 2024 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1717581752; x=1718186552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NO7F9EHmCfMVLNTmkHeL5YVPdJp9NbGrpbBAR/81NYc=;
        b=dvHxNi+1QOWINV9XMUnpadsxPCRIqMJEIWd2skQqnPeBgm2E6Bsum9fKWBgB+H2ncj
         CTfekSqjVc6xdeTYnmQzJdUMRJsTvX9ObinFVRmofIIpxaNwpISE0/lheQsXPUx7TD7y
         ySdHucl/iP3WDSxTT4goswKBDSRY4qwUkJoTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581752; x=1718186552;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NO7F9EHmCfMVLNTmkHeL5YVPdJp9NbGrpbBAR/81NYc=;
        b=ZVKaZvaJJilcNtV1MAQCuovJPQdU+WEl/6j6nH4LlELTl4fMT4kd49YGRdnUkbVXQ5
         BlO7RdKn52TJTm3Bq5S9WAUEpQyyEivUsFgfKB6csDKpL/DNp5WZOtVI/pd5t5OrOciC
         iq7c6iWIFYJAQNVI8Sqo6WUclUt8AsuoUgkCenz7xuXTBg6lsMTENzHcP9jU1sqyQVXo
         7Jvxh8aEcgr1bY9gz+6iNzGp3BbP2cP0s5SJ6j139m+4muApp+jvcfE9nq5mbiAsGtki
         0tZ0aXq6BN9QnebJcsAdKydb9qlt3FlJueJmdcS1OxnOS+lJMAcWLLjeJibdJiFzirav
         pnCw==
X-Gm-Message-State: AOJu0Yzyj7TEFZFoIoE3WJcbjaEfuSbNZoJB52Pq1Ckov4l0Ep8c8uhZ
	Pu4Ovp89adeRr4RvEE3D1CzaOZ4hq4dN6AsTTnuqM7hF6pcWptujMRA1/ZtKGFnAzWXPBGApaBp
	gyWlhWdm0p4w/rj0zjexuKDU09zHH7RLzu0X1infGc5ze7SJMMaJXLS17YOxPVMRxmJYAgRrx15
	8e1AxAXjAzpJNbtu9PsHC3T9/qccbkxSvvu5S/BGY=
X-Google-Smtp-Source: AGHT+IFTTITMdPWAlRmX6bhcFZWwMrbPm88g15a0NjmikiHse89Ival0elI40cCHTCMQkKrh71ojB650jh5l72yd0Ks=
X-Received: by 2002:adf:f806:0:b0:354:f444:c21e with SMTP id
 ffacd0b85a97d-35e84067778mr1390518f8f.22.1717581751940; Wed, 05 Jun 2024
 03:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 5 Jun 2024 12:02:06 +0200
Message-ID: <CALYqZ9nHSfMum16OQDNxSvBE5ue0SL3+ehSH7mo-OvzbtZwZnQ@mail.gmail.com>
Subject: [PATCH 0/3] : XDMA's channel Stream mode support
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I've implemented the STREAM Mode support for the XDMA's channels.
My main concern is about the EOP condition as I have no means to test
it. At the moment, I've just considered the transfer as completed.

My implementation is done with 3 patches following this mail.

Your remarks are welcome,
Best regards,
Eric.

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-eurosatory-2024-in-paris/>

