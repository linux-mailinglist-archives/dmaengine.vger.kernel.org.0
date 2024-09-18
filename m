Return-Path: <dmaengine+bounces-3184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E497BD01
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCC828170C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6410189F41;
	Wed, 18 Sep 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d67vQ3U1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48186172BDE
	for <dmaengine@vger.kernel.org>; Wed, 18 Sep 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665977; cv=none; b=jZHM2nAS++nf+xB1n1Z2N3lEx5BHDaWJzMg4m3skTeazB3hAIcUcwcUp/VEblU0z0biCVM0plvVNuyHNGiKhck/ha1a6NmnMC1fVmNVq6By4WOEG9IDvQIwN/6BFWB4iAHA6LJZXRgMkkh/bb2O6Uh4dFCjPaFfyoK8sXy3RZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665977; c=relaxed/simple;
	bh=dNOyc6yx3NH63mp4ylHB1CXRSC1Yw4nnqKxpT7UdOEw=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=kQ97b08wVILA/D3hDyVvUP4R2tTHne5uj9jEBr0qoCaTJLTRbUoBfb2THe8kr76ropoD+OnjKOEoT+MOklCYXmVBBr+JUfjOOyZKX10mPF0feAJTXBe/Ks2ZnbAOj4guXpmvdD017QWkx0fsheFuWUDFMgCMc1dcTcJcM2Os/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d67vQ3U1; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20530659f78so4533455ad.1
        for <dmaengine@vger.kernel.org>; Wed, 18 Sep 2024 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726665975; x=1727270775; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=d67vQ3U1Y5L43V/HBk8zjHf19wYHH6A4k5/2rXomPs+ip8xKoadCvp87w/emGg9Dk0
         Dx0E9hhMKqKXWv+kPz3/G/mc/afkyjBfB1EsnaDPH9zL4PnQTL8/I+eDCaDQJ2ivugiE
         JY5WL+KM7lQBDl+q/txdlKN5tHTbej9km5BZso0ngd6vbApo7b+Lvzm/yujaMMjZPUPG
         bGmYUc5W2bYU2LnPE3CRvzT9YAJTjWWYNTR0v3+J3q5KrkXxG4Ot2W0FPuomk+pJYMrc
         Mycoau0ycN6dMfm8Wy3Tzj163HHpoWfPckXOIVXjRMCWmff/S3Xa+dkK6YQbIWsjrLzB
         X7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665975; x=1727270775;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=U1XdYvbTtK1Aq2a3uedAgVyEudhpAPqgWlxOqdZjWVIyfFR8G1m53wmIZ/TuIck7jc
         xgUDalG0gheCr2jSn36duzQiY+aumfUsXkF7hG30CjD/kYpb1VGjJiTKEM6koF1mCQyk
         nfUSPCeS23ZEq63p25AdjbItfodEyN/qOzLufo6JWEWQGgBLkLJDo58B+b7t5RqlEABN
         dZuKFWxaPvdQR3t/f7PK+2G+qoNhh56sOqcU8QvV6mh9C1oU/jaQSVGYc84MtXr+0mOA
         UfsqJ24U9Sd6PFIqjhV5j+SJaycyFX08DKawS1rI9r2x79ug71dFQHew0MPEPA/ogP/z
         Inhg==
X-Gm-Message-State: AOJu0YyRjBWoKNVyfctccwRPmOfzdXO7n73tC4el4X73/zgat5oAb3JY
	qw3aDgCQItCDQwWDczsJd1h+srK1CgRqH6/bgKgEXeBqNwFJbXnybHfdWF/v
X-Google-Smtp-Source: AGHT+IFbICZnQINpsCDboMRUuVFUPP7PmuDyNkTgfcq3VftFzxazW1nlEb6JZVNz24LjKhZfq3byfw==
X-Received: by 2002:a17:903:190:b0:207:14d2:ddeb with SMTP id d9443c01a7336-2076e4249a8mr148680005ad.13.1726665975586;
        Wed, 18 Sep 2024 06:26:15 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da66esm65304045ad.49.2024.09.18.06.26.13
        for <dmaengine@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 06:26:14 -0700 (PDT)
From: Michelle Fangman <nyakeyaevans43@gmail.com>
X-Google-Original-From: Michelle Fangman <michfangman@outlook.com>
Message-ID: <adf889a9eb61a6befbfaf64a1633ad7e3fe402563834b22ac5cd79d5727c9176@mx.google.com>
Reply-To: michfangman@outlook.com
To: dmaengine@vger.kernel.org
Subject: Baby Grand Piano  09/18
Date: Wed, 18 Sep 2024 09:26:08 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm offering my late husband's Yamaha Piano to any music enthusiast who may appreciate it. If you or someone you know might be interested in receiving this instrument for free, please feel free to reach out to me.

Warm regards,
Michelle 

