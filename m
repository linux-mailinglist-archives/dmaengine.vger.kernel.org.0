Return-Path: <dmaengine+bounces-6799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328BBD00DC
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52C304E16CF
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8972D35965;
	Sun, 12 Oct 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVmhnU/w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2F21B196
	for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263224; cv=none; b=qSUTJDLsBBeeJQVX1xu00e8M6k4c8BOzKDIn4oIyNgvgfUGh+QqEObseK4nGkwk1mEAACBEPnfkWDSZnEzmBLGg3sThQXtxHeuNFY7uJe+1wLz2shi90PyPTRTMYLScqpT9LY4u/XfLaUn1wu3+9G3y27DAhG69rziJW+NcuIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263224; c=relaxed/simple;
	bh=It7Eaj5J84HbEM6VAsTq3su8JCb3geSlP9Uww5PYuFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czenycbMM+lCQ3IAkOSMmDao/GzBeeVZVo4u0KHLfkcQaD9KSTu8lcp1Fdf7u51jwy5oAy00rI/SiK+hKsmEmdb60VSPxv916+PuDSE1HyodmHraVZcaGHcF4My9ZFgU9Lbo7TtxX3g3D6j0WTY007WU7JnsBx6WofKbX+AAjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVmhnU/w; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso3896597e87.1
        for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263221; x=1760868021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BN1tqWOn9gDFeGRfAyg/XCO1Cw8y5MQy41++mkAI8Kg=;
        b=DVmhnU/wkNS6Sv0yU8/hi6itdTRc1FXj8oaW0nt8t1vw0B5oMOXzOg/h8uv5xGIKLW
         4W28EuJe+afRl7chPW3bgc0j8JV5aJn07P6Lx2GfpaL+uIOnrekVKt6DK7VeZdjg95IW
         c1ymDCH7oF0jbMYQoNhzVI5UNvZHeegXO/YIgnnQxmrIWVwAzKVqMPCunT4cJmXDvb1o
         d7dv7O+mK2M5QP3oS76wkaMl1ZYO4KHUSGUGku1WkLXtkbpuEQJtne9W5B1pC4EcL6le
         R66swZ8u01TujgY9A0V6UHJ2d21KnTj/HGW6S+3PEox6ZnjPE8DmjMxCNV6qGRwZUmMU
         0agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263221; x=1760868021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN1tqWOn9gDFeGRfAyg/XCO1Cw8y5MQy41++mkAI8Kg=;
        b=pioJijLxMDLnHnvqV7akYPrCbRkQMTqq3yeg5uRsadHYYA93+2EaKEBXJuUt0xYDEQ
         thxUi+j5/4vJo3g4PE7ZDMwanJUqzgY0G/nGiQzO/+kM0WVohY7KD9/LnRBjofgxsoOQ
         36DPG1sKJrCn+Z0Yl6W6KjQGvfpOe+Ebyl2hxDR1UUbeD2Hhp49UpC+HF+V9E6APtfE9
         mp5LaJJeMytduEzMdHN3O2mcOfJ/+GVW9q5z1wH7/MWwwZbc9A/9EH0Fwtm3F5IviSqp
         Jn3Q2/QueYgljNZ+Jt9AsKwbMJ8Z/wlyxuzeai1RGAHBnMUrZPZaHAX7PHYNdyMqEAW4
         s6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV362LNbRWDrq7o+FLAafAjNRoDG+Hulb5wdO64t0Njl1nJ8w97BrjXA75IOWhK7QG1ugTgG7v/CI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynl+LczoB+mqI2w+9UvFYMnzMxMYLytzlEfOS1F24eCZw1VBXC
	bEZDfnMvVCkq6q/XXxfkyNn2bysNU4ZgV+EOQgiZLn87O5NHbsTSIum1
X-Gm-Gg: ASbGncuzEXvnaxj8/t4UHXy1ls2fpRSEFuqLzV4JuQJg/RETpd3qqnXMoNf9F5ssAcm
	B+vUn7amFBCcW+gw++HsCgrTANHCcmNDExN/61DJVFdIdUprhhjCGG+oMU0UzKmsxZHdxwucMTD
	VXXSFEp7UduHc50k1CluGDGdoobtMnLphKFJemo76abkAALzgtb193HAu5gQwFXJ8cAe3Bo6ts+
	DrkDhBqGYJr7Lk6h2zp/YAyJJYAYn+79JcOVJKBU55iKTPJNvUdXaYuRx4nwcjnHnZ5ddzu5srm
	QrflINtpnDn+6GyAuDNX3fg/oW7rVrtqDd7+VYBqNZCdnefZ4iF4qLB7grUUDXtZnnLYgUS3scT
	52SauPsqy50tJQ46zl0tRQOWeykfEcwluxACiKEjBvw==
X-Google-Smtp-Source: AGHT+IG9vD6QkFl0LzgYmbvJIzmaxqTeBr5K7c4g7TX/qTzXTdCa1UKjqjX6yBXopM8xIQDRpj0hpw==
X-Received: by 2002:a05:6512:61b1:b0:586:2e4b:22c5 with SMTP id 2adb3069b0e04-5906de87eecmr4743503e87.56.1760263220536;
        Sun, 12 Oct 2025 03:00:20 -0700 (PDT)
Received: from NB-6746.. ([94.25.228.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585860sm2823882e87.128.2025.10.12.03.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 03:00:20 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: a.shimko.dev@gmail.com,
	dmaengine@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/2] dmaengine: dw-axi-dmac: PM cleanup and reset control support
Date: Sun, 12 Oct 2025 12:59:58 +0300
Message-ID: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

This patch series improves the dw-axi-dmac driver in two areas:

Patch 1 simplifies the power management code by using modern kernel
macros and removing redundant wrapper functions, making the code more
maintainable and aligned with current kernel practices.

Patch 2 adds proper reset control support to ensure reliable
initialization and power management, handling resets during probe,
remove, and suspend/resume operations.

Best regards,
Artem Shimko

Artem Shimko (2):
  dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
  dmaengine: dw-axi-dmac: add reset control support

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 72 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.43.0


