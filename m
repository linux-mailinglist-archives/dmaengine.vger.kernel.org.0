Return-Path: <dmaengine+bounces-4025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63FC9F7275
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 03:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9579A7A06FE
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB270823;
	Thu, 19 Dec 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="cxY6YHoL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA34D8DA
	for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573916; cv=none; b=bUPKunNLmI5dp5jgFqK+qXVaMSyj/VjXJ4TaUS83n2z2I3hMFu/pqlPMlbjl5s/yctdjllG1AlGobJPNO+vzuaduxNfyf347PhDwYfW4GRDP4clyUHQWHAItUott+Ebaat0cD2jHT4Wa4FfiYy33e3j+IVlscow5PTZefMC61Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573916; c=relaxed/simple;
	bh=qyDyQHGwy+cI+8qWI1wUMGLJLBuVq5CrC3ljWt01las=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOpMurx8mQnivNsxnpak/qsI/fkcqrP5LIfyBcDN6ewyBNxyZ8L+cT4V8QVmsO/CYpaFxl/J3t/i30Cp34FgsVe9NB8auREopGhKKaduaaLNlVduTLt0Rcn7k8ghvlaEqF+4S2+niSa89bZSr3cA/VDhL8A1RTNUWzlJ+VKFvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=cxY6YHoL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-218c8aca5f1so3497535ad.0
        for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 18:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734573914; x=1735178714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcGMXBL57yLCZx8LzDXoHrQXCaiO3jDOSZYhf2bOqrY=;
        b=cxY6YHoL6yx08IA9omJI1TNUjegLAwifkSn3lF+r0GgOh9/Gkh/nMXBa+MC0VKSU8F
         st8Tggtc+m71je+/bCah84OSTVgSrbBU7Ruto9wzsMsNVlT60xHgFux6wa0KMgLQgQM6
         N4kQrRMGaqQGoZVfANNKDDnyey2xL2o5kvsJORMRE/1I56cE1K08FQPNYytKTtAKzq3o
         cQBhtTrnzw33upT3wW9MaR8RPixiLgtm+Ev9hZrcNZEtHnOJXlz/4mIPQiJbHHae8Iyc
         FMxiPGFWJItFcl6XfyyshN1slgfOwf7prd3BPcw00C4l3PMtS2yGzsdcN12ouy7VMbGq
         +5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573914; x=1735178714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcGMXBL57yLCZx8LzDXoHrQXCaiO3jDOSZYhf2bOqrY=;
        b=p951Z6aBLPMy6f1hg7p3P73oeDX0s24T+ZJ0XUr/gaUAn1Bs+m3dOEjc3vvL16z6q4
         mdmwOVYLltl1h1q+2UD5jhM9mSwhpHseg35kqBAnf700V90dlL+zoTTGt4IUxslhTkUT
         Q1PJ86R0IqSBdy340HrjPB8zGg/dVAoANUvEG2Nny93y24vA+F/P1vqcBvBlEqHIZYY3
         lSFvweKgNDDTlPDWloBGK2JEc5WmKY05ZXXzUHV8myeauj1w/2dhJpl3aR3kD2ydQl82
         hdVzXFs82U1Ei1lDUL6D2UMlYoQW5haHM6PgPbPrf4YmGADCaWQ+1wbIkcFcMU4ldMyd
         8Otg==
X-Gm-Message-State: AOJu0YwMqG5jtagvtxWfBwLV8kelHCZydnBS29bpK2bLUfTwjO5iQyVZ
	Fha/55iaeIMtAPN7ByI+zje5pRZj0BULlJOB36W7HDNmxvrPP2zotbeaIKLFtO0=
X-Gm-Gg: ASbGnct+7ddJwcq8BIehfeTEItX0u76RM/Ag2905NQLhONaIuygQgKE32x8IxBIWcZF
	zCTRiZ4jEQMZvr1NdEQfC8cYVYz/LNSHPOuIb3n0cpp0Row71FEyUvg9bt11mHsHWbjp+mZOrAJ
	aI3Fyf08oix0zRho5ZU1+etbtLrJpQ2ZXMbgh7GPg0l1O7tIcJgTelxLtc3mW9mjwY4Fpq4mpb/
	d+mnYXklZ+oYhR3XxKW0D6CNxCuN9R8RIuQ0AKegLCevhWXGypB/OicUXrZMsUC0eAtIBb578IP
	+Ac5fFoHEhgt0a99j8DFGbYvxfqiR7ZhT+CXb5pIecQ=
X-Google-Smtp-Source: AGHT+IFUBvLcRPcM4ykKnLkt7f9h+xO1BhqRkXOjSlEOGxJ04aCKX/2/H9S5Zm8C+900m63N8z/kaA==
X-Received: by 2002:a17:902:e844:b0:216:356b:2685 with SMTP id d9443c01a7336-218d6fd78a1mr79747955ad.11.1734573913822;
        Wed, 18 Dec 2024 18:05:13 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b84sm2044295ad.50.2024.12.18.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:05:13 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v3 0/2] dmaengine: ti: edma: fix OF node reference leaks in edma_driver
Date: Thu, 19 Dec 2024 11:05:05 +0900
Message-Id: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes OF node reference leaks in edma_driver. The
first patch makes the loop condition simpler in edma_probe() and the
second patch actually fixes the leak.

---
Changes in v3:
- Split the patch into two.

Changes in v2:
- Get rid of the .node field in struct edma_tc and put the node in
  .probe().
---
Joe Hattori (2):
  dmaengine: ti: edma: make the loop condition simpler in edma_probe()
  dmaengine: ti: edma: fix OF node reference leaks in edma_driver

 drivers/dma/ti/edma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1


