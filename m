Return-Path: <dmaengine+bounces-7365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 992ABC91D46
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DB834E3542
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3D30F81A;
	Fri, 28 Nov 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yLQI8T4r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E12EFD95
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330256; cv=none; b=UWx11qyIS2r4/DAHqNI5+UPqLDpgQEnxSe5/cgmYiqjRN9b3yebBpmkT8j10UC1WYQEPZE2VBpLSw2w11zYkpKVMPPc+Sl3hm4pUIH/fKn8TWtodW5C72lPHre70Vc1QjpWIVQISArxtn5G2IVDuo3ulmfpDkHVo8G+9dAWJOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330256; c=relaxed/simple;
	bh=4khc6stX0k+SR3+8DlSRY+DGyoru5P/CEeBIvZI1qlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iM+p/IJ0DmpStkucBQG443v8EpeGzRa2hEtSk9HuIxCB/z+cBlFiVUAsRYPodYOnh9o+mOXt0t9jlkSMUFLZUCYm6MZiA4YVANQqRShZp5nOZ83K4SI9uGM7eUCel5Qmb4RwCEfOF9D18liohtiiXfNGwm+ez5n8oky909dxLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yLQI8T4r; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso8219505e9.1
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 03:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764330252; x=1764935052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afZZW9qdftp5SRXhu9OIj/Ikh4syLmLNM6zCl8JfOhA=;
        b=yLQI8T4rfaPGm9IWD0LB+s4RMcWiELpY22huAtmhc0F9qhHUqntwOU3Iw49JskBCN2
         FYNDR1/hDXP/PECGPKI54ueTsItvpNd9bEQzC/T6B6Fl3t56hS+2X5p64GFRglQhJhP8
         LWI6GGp5k2Aj1pKkxwMQ5YN2ETQh44e7erqO6tSsk23VSu2CJXeUYNXOayB1nPeO3BKO
         Z0jvDAKokbQHU34MNG9Fy43eg+B9Qltjlku2NNSk5vVo94hDBRKWCEsnCUgNKIIHz8Iv
         +mhm+EKbtR8hzoBB96xbeadKwwaU6xgTR7QdsGDTkcYPWxsSbLdC9TyhV4oa8pDEXXWd
         YC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330252; x=1764935052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afZZW9qdftp5SRXhu9OIj/Ikh4syLmLNM6zCl8JfOhA=;
        b=huIZ780hOQ0pIH500s4zilZI49BbsEXvToFptdrXCcQgCrSFlLdnTk7PdNNTdKsYp2
         KUKqAF8FY7oOcVbnbuMEseP8c4PFGU4BKaRdM8v8+Rd31FBxOX4N0ZBq8g4giCibsO4C
         OVs2tWVq4YZhdaQncCf//DCmIUfBOSdUtaXLoW9YATJl/1kRBvufDxX4qpeVLMafzgdi
         eIFysHbicxHT3LKj860IghV82cehGEUXs+y9i15TExr1aOYvNk6oYeADI983M2l9N3Uh
         BS7YzJi5h8pPHPKLbeayiKHdZZejYNbhp/ocyMvMkUlI+l3HLRsoxRHknmNeHPkxsIkI
         B25g==
X-Gm-Message-State: AOJu0YwgKgFucizdFm0ct9oMTZyH4xdVRFaD2EM9jHNeULQFwF9J8yai
	C44SxHUc9GuFXCLLllENo6uQG+nZ/ERKv1k+0qOX8C2j4NlExB7CqsSZu0saBXOX+/Q=
X-Gm-Gg: ASbGncsshxz7SnUXwwbLzr/Ns07O+xyXj1YJ2VJKfBcIrAtIyhbQgzyGBWqoXRYDm0s
	COuRonSp6Xqp0fH1XyDxzWkTLnrGlBsMLNl17QChP/mmi6HIfXX9yMnaXkQ9Zm2vqDrdPgK+IYE
	4xHenRmTunpeeNxxCcGpQt2NoFuIyD0tN5jj6iTRkFXb0e+y/ghpQQnCs34GdqNot5dKUYDb52v
	uT7ro6oBjpgh9nRHcqPF60uL7do1NsFdqhwB64O6sw/iUvwxCj/dr2OfnZNyrh+8Hg6NwCVhBGq
	r/6xhdI7nPFb0iQyGPfoqftozRMoce7fBnL+P9/cLjjSwUfLwq93wGbYC8ealqMQUF7Rff7Za5b
	B3kk1SEJqb3MqKiJ7V/vtzGg8c1oZ0ufTkOpLHCnV40mOsthN4hJF3JnG/44CRwY1MU5RFa8hJI
	MhDweMfbko0QWXyoyO
X-Google-Smtp-Source: AGHT+IF3zfvu+7wPntsJa5nMDSCYwSXTfuvBzBgPmvlXYCnQSl6OkGtkzf4+1RON3gU7YypBm0y+yQ==
X-Received: by 2002:a05:600c:3b01:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-477c110325dmr248783535e9.6.1764330252139;
        Fri, 28 Nov 2025 03:44:12 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm89888445e9.1.2025.11.28.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:44:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 00/11] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Fri, 28 Nov 2025 12:43:58 +0100
Message-Id: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6KKWkC/22NQQqDMBBFryKz7pQkomhXvUdxYSejDlTTTkpoE
 e/eVOiui/nwPvw3K0RW4QinYgXlJFHCkqE9FEBTv4yM4jODM66y1pT4oDDnYKTZo+dIilRxe7V
 24Nq0kId35UFeu/TSZZ4kPoO+9x+p+bY/Xf1Plxo0yOQ99a7MV59vsvQajkFH6LZt+wC+FHF4t
 QAAAA==
X-Change-ID: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Udit Tiwari <quic_utiwari@quicinc.com>, 
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
 Md Sadre Alam <mdalam@qti.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6263;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4khc6stX0k+SR3+8DlSRY+DGyoru5P/CEeBIvZI1qlw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpKYsCXvc+JuhAbpBmEvwsMaL3pa0+mw9pTOsdx
 5xLRp7TzNOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSmLAgAKCRAFnS7L/zaE
 wzXiD/sF+q0Zkhqo+RZHB8+evczRi1o5+PSLZIlVbVC7vozr2EQiQNmasfjJcH3b3kYJ+5AVq+E
 WcXPUNB6rO6lDjEpH0GhlSz8SJ5Mi9FmqPxeWOyoRdjARH9Xm9IECH25N8rAGEgxwPZQ508WY8z
 jwkSYLWptuJ5J5vEYyuXRzXhpBwbmr3JVzfznySnPRvnDNsHLcZGXvQOqSBH3mlFrZpvr22BJ1/
 z2nieGUujUqd8mMu0KPkOGZTOTU4aBd8WNnb2WtTCwKN5ziuW5ScRGlGZZRFZP8MM2DbeTAXLWB
 cLYbEgrH954Kaq1wcBFUw5/+PJuNCmztR8MoWgaCOvHayBVbsa9M0K6vYLFxbN3Zx36NEbK+5Fi
 mgS63q24oMAgbKAWFFnZAIJWDLLEBtW9qJ5csP2V/RzKjkVpSBzv6dUlUDIgF9lZO5clUKTub14
 GlVVDgp+idXmO5dQ/1olfRBWpPQFsJcussCUgnOt0EsegiHsOONOt8ppUigPz+IeH9IclxZhoxi
 2PPN5RYOZYhcaKgpxQ1r3mEZqPvDdS3kz0d/xJME9ePIjD42elMlJt1OKCvlT5tNtI49EvFG5oz
 c0vEfn04kp0KDaN6Z/aQBa03ORLkqz6zv5XCX6bkMumsXhM9rFrTTA2yzUzT+We8J0bG2LppLj7
 4Tbih7VOBCZwHaA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Currently the QCE crypto driver accesses the crypto engine registers
directly via CPU. Trust Zone may perform crypto operations simultaneously
resulting in a race condition. To remedy that, let's introduce support
for BAM locking/unlocking using DMA descriptor metadata as medium for
passing the relevant information from the QCE engine driver to the BAM
driver.

In the specific case of the BAM DMA this translates to sending command
descriptors performing dummy writes with the relevant flags set. The BAM
will then lock all other pipes not related to the current pipe group, and
keep handling the current pipe only until it sees the the unlock bit.

In order for the locking to work correctly, we also need to switch to
using DMA for all register I/O.

On top of this, the series contains some additional tweaks and
refactoring.

The goal of this is not to improve the performance but to prepare the
driver for supporting decryption into secure buffers in the future.

Tested with tcrypt.ko, kcapi and cryptsetup.

Shout out to Daniel and Udit from Qualcomm for helping me out with some
DMA issues we encountered.

Merging strategy: either an Ack from Vinod or an immutable branch with
the DMA changes for the crypto subsystem will work.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v9:
- Drop the global, generic LOCK/UNLOCK flags and instead use DMA
  descriptor metadata ops to pass BAM-specific information from the QCE
  to the DMA engine
- Link to v8: https://lore.kernel.org/r/20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org

Changes in v8:
- Rework the command descriptor logic and drop a lot of unneeded code
- Use the physical address for BAM command descriptor access, not the
  mapped DMA address
- Fix the problems with iommu faults on newer platforms
- Generalize the LOCK/UNLOCK flags in dmaengine and reword the docs and
  commit messages
- Make the BAM locking logic stricter in the DMA engine driver
- Add some additional minor QCE driver refactoring changes to the series
- Lots of small reworks and tweaks to rebase on current mainline and fix
  previous issues
- Link to v7: https://lore.kernel.org/all/20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org/

Changes in v7:
- remove unused code: writing to multiple registers was not used in v6,
  neither were the functions for reading registers over BAM DMA-
- remove
- don't read the SW_VERSION register needlessly in the BAM driver,
  instead: encode the information on whether the IP supports BAM locking
  in device match data
- shrink code where possible with logic modifications (for instance:
  change the implementation of qce_write() instead of replacing it
  everywhere with a new symbol)
- remove duplicated error messages
- rework commit messages
- a lot of shuffling code around for easier review and a more
  streamlined series
- Link to v6: https://lore.kernel.org/all/20250115103004.3350561-1-quic_mdalam@quicinc.com/

Changes in v6:
- change "BAM" to "DMA"
- Ensured this series is compilable with the current Linux-next tip of
  the tree (TOT).

Changes in v5:
- Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support in separate patch
- Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag
- Added FIELD_GET and GENMASK macro to extract major and minor version

Changes in v4:
- Added feature description and test hardware
  with test command
- Fixed patch version numbering
- Dropped dt-binding patch
- Dropped device tree changes
- Added BAM_SW_VERSION register read
- Handled the error path for the api dma_map_resource()
  in probe
- updated the commit messages for batter redability
- Squash the change where qce_bam_acquire_lock() and
  qce_bam_release_lock() api got introduce to the change where
  the lock/unlock flag get introced
- changed cover letter subject heading to
  "dmaengine: qcom: bam_dma: add cmd descriptor support"
- Added the very initial post for BAM lock/unlock patch link
  as v1 to track this feature

Changes in v3:
- https://lore.kernel.org/lkml/183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com/
- Addressed all the comments from v2
- Added the dt-binding
- Fix alignment issue
- Removed type casting from qce_write_reg_dma()
  and qce_read_reg_dma()
- Removed qce_bam_txn = dma->qce_bam_txn; line from
  qce_alloc_bam_txn() api and directly returning
  dma->qce_bam_txn

Changes in v2:
- https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
- Initial set of patches for cmd descriptor support
- Add client driver to use BAM lock/unlock feature
- Added register read/write via BAM in QCE Crypto driver
  to use BAM lock/unlock feature

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

---
Bartosz Golaszewski (11):
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add bam_pipe_lock flag support
      dmaengine: qcom: bam_dma: implement support for BAM locking
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Add support for BAM locking
      crypto: qce - Switch to using BAM DMA for crypto I/O

 drivers/crypto/qce/aead.c        |  10 +++
 drivers/crypto/qce/common.c      |  39 ++++++---
 drivers/crypto/qce/core.c        |  28 ++++++-
 drivers/crypto/qce/core.h        |  11 +++
 drivers/crypto/qce/dma.c         | 176 ++++++++++++++++++++++++++++++++-------
 drivers/crypto/qce/dma.h         |  15 +++-
 drivers/crypto/qce/sha.c         |   8 ++
 drivers/crypto/qce/skcipher.c    |   7 ++
 drivers/dma/qcom/bam_dma.c       |  92 ++++++++++++++++++--
 include/linux/dma/qcom_bam_dma.h |  12 +++
 10 files changed, 345 insertions(+), 53 deletions(-)
---
base-commit: 60ce1919ad707c77df15449238bcb665020ffc93
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


