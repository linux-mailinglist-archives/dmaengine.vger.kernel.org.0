Return-Path: <dmaengine+bounces-6201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F2B35A1A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE917AB0ED
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1C2F8BCB;
	Tue, 26 Aug 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf2+DJAK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1982F6164;
	Tue, 26 Aug 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204223; cv=none; b=ggSdoDYOAB/euSoL4/hpeoEDpF5gegyfts5lj3CUhiuLjevdXJGypCdavgm4ckODRpu6auSUa3uACuuwUCyLkxQ3Yi91t7KZWoIl6DD6gT5ELUSZ/RYGGVVnA4viAR4ZWt0KUP4qwNJlzFcVL7gbQkJ+cVDhGzmIL8Y77x9natE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204223; c=relaxed/simple;
	bh=O5QaWL4fC9ZfJKSjodA0MK3AH6Gddyny4ad5oPhmaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBLMBsIzNLfPhJUBqPOK2cV7CtupFvJDwdZWNyDhS09MpfcI1v6jS8388lnis+zpCkoemmvyhZjLbsKMQ+il/f1PBN44dfBdJFF4bTwKWt+ZU0VZjVc93b75b4z5mRDrkmANgGLK6tz0rQNqE3WomH22GWGg7hePS9g7MkKeC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf2+DJAK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78d5e74so1036585966b.1;
        Tue, 26 Aug 2025 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756204220; x=1756809020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds6xAU6+uuVJ+pTYkEOyBSf6qVVVR2jmuQi+4247ivo=;
        b=Hf2+DJAKu6KUJRwHdRV/hhjcnHm6Dse0dZ8cMDCfzcUZ/+PjS6wgqlQ9Pj7YWd8kvE
         LHmFEdawoPc/y6SMJq50wS1n3zgx3LP0Wtbcbl1UfdouBKVYfSdfxmta266mumX+U239
         LgWwJRVl/xSYeoUVsqFiDOkKdxUIReqjwS5AOLN8b85eTUxgMjDcR2/yJg0vqJoJdz2K
         jbOMkkuopyCNhQutL7/qRoqa94Vhwexcy/FeZ41i5JiNp+z2p1nWVolBHqd1sTqgOBph
         8iUDxLV8rsoti+3LSaKtxjQZdEKUF1EcXTwN1nl9GDOxEb6/inR42DtZQgyGnYQAgjqY
         MZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756204220; x=1756809020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds6xAU6+uuVJ+pTYkEOyBSf6qVVVR2jmuQi+4247ivo=;
        b=k2ygvB3fGUzBexi1+zGDlTEM3vnOYS9rO8lgKqrrTpZQJ2wrkyO9TXS1sHKO5ozwr5
         mhsoGI3pSGpaDita3xjE/CZqMgxY597v2CApxdzl7Oh+B6+rLCwbRwbJGyaaRD8CkO7a
         y2UpD3UZefzdv+G9OyVdepEvMzVAVHho1hPyaRuxqPW57u3Z4UmbvywJ7PULyct+LHY9
         9uXZVDKC/JX8aZg6FfIlbSEfuP7cu6GiUXdFVguaNXKqOM7P1FBSdlGQi0AZ4dOWWP66
         1O98HIxFuYQa6LtO08uPRUQb9LXfHsLZdy+JPKTJpCbvqkLbaBXU32/nVNhEnbRh2axa
         sklg==
X-Forwarded-Encrypted: i=1; AJvYcCXeDqSVuqCptB6CQRSOr3QxBaYmQfy/ESkUqIDQOAPGTJCPdtYmCc1aPWHD3koQdREXXVd3uS+HjMFvzTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5URES+04C99WakQaic7rnQYJCWA1whU1u4I2i8aCCkySY0z41
	fUyJf2wXh0Np1fQgFm6WBpZmzxOX0rET0H2u4TSe01qS9bL+4WjXE9RFaXlr4g==
X-Gm-Gg: ASbGncvHloeq/NdPODHK4YHg1NaROBj1ABTR92vbCfVdspBh4pAld+pLM93tX7QCtse
	U5LvpiDiighIhqgsJUY/BxN8zauruyHgfcGAV5TOYbj7nAw+wYdKmjxUkwbhbQPWuz+wYaiUXNW
	KT13RYIKQESLFSpgykfhdP6ufabFT3WI63qAVGwefWD3ZBkhYSrsccaKwzi400u+3EwJXSl6Zvs
	FONSxqZgxttZsyiAUzRBzInLpS0R7Zdv2/QPAF7j4SGKtXIg7SArABdlljLcIKWXqQdnZJd2sNb
	53FOSpfd2E0+yznRUZzSDj6DAz7TNJTYQMdmHDoOjXRPDPAGXmFXKW43salALYSdsBne5I/iRqT
	UU263xekQKybQrO4=
X-Google-Smtp-Source: AGHT+IG7awi/UMrPhwldRbedylVcsuFF30NymvcqE3o51OW8akjKYmfQEZpDOc3PLfiG202ZGXCJSg==
X-Received: by 2002:a17:907:7242:b0:afe:9f26:5819 with SMTP id a640c23a62f3a-afe9f265912mr235652666b.28.1756204219602;
        Tue, 26 Aug 2025 03:30:19 -0700 (PDT)
Received: from NB-6746.. ([88.201.206.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe4936a335sm766732666b.114.2025.08.26.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:30:19 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
X-Google-Original-From: Artem Shimko <a.shimko@yadro.com>
To: dmaengine@vger.kernel.org
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	eugeniy.paltsev@synopsys.com
Subject: [PATCH 0/1] drivers: dma: change pm registration for dw-axi-dmac-platform's suspend
Date: Tue, 26 Aug 2025 13:30:14 +0300
Message-ID: <20250826103017.1891990-1-a.shimko@yadro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

The SET_RUNTIME_PM_OPS macro has been deprecated in favor of
DEFINE_RUNTIME_DEV_PM_OPS which provides equivalent functionality
while also supporting system suspend mode.

This change modernizes the power management implementation by:
1. Replacing SET_RUNTIME_PM_OPS with DEFINE_RUNTIME_DEV_PM_OPS
2. Removing wrapper runtime suspend/resume functions
3. Adding __maybe_unused attribute to PM functions
4. Converting direct chip access to device-based access in PM functions
5. Using pm_ptr() for PM ops pointer registration

The refactoring maintains all existing functionality while improving
code maintainability and following current kernel best practices.

Artem Shimko (1):
  drivers: dma: change pm registration for dw-axi-dmac-platform's
    suspend

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

-- 
2.43.0

