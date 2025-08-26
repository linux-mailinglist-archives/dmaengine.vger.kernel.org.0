Return-Path: <dmaengine+bounces-6200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A787B35A0D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060AD36020E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA92BE7A5;
	Tue, 26 Aug 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc2weJaT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9B2BDC2F;
	Tue, 26 Aug 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203997; cv=none; b=lt9vqm09eYTXzMOWQBglK9ozbAptBzNEuaagdXdAavLpv8SQz8ijC8STQeF+KBLfbWk3YqWCMdtx8tFYqSk6csOkPBk2ImQXlXbAvWvP/GeG2vAJZmsyjB+F54+ts9ZEH/h2hOGCQhEdPG51aGmHIebq/OyEBrb6WeVXBEUHeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203997; c=relaxed/simple;
	bh=O5QaWL4fC9ZfJKSjodA0MK3AH6Gddyny4ad5oPhmaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edch0sJCFIFvURgZLe/xsQ7jXOfX0geVgRaQ7AaZkR88fbnm5iPh9+yQVaAhPcdPo/ookWy++6gSv6bofQNaC5G6JOgk65MrEQP5KezUQFXYskd1/uxIc+eyLIg8wRLmTkFs9jzqT4X51vtsw1EddbZmXHCjeXN6D+V6y0pOG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc2weJaT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so11242771a12.1;
        Tue, 26 Aug 2025 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756203994; x=1756808794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds6xAU6+uuVJ+pTYkEOyBSf6qVVVR2jmuQi+4247ivo=;
        b=Gc2weJaTw4HKhI+dmvTnaU3Cjwz+Ilq69q9gc/Pa2BaRYAfEt7RNHRJTK3Xi5PbJrg
         PC2KKlAm+wq2QX1VDOTYR5vzFbIJgQi7I/ws6/K1eGt7f47keMr3j3MRfIKKNK7h3uWs
         3Nam0WE1sUaOLfKEJxhUvU0tyBznfZDTOXRL8uFDHgy1fvrtp9W2DZdK7HKcKzjTsvrr
         yP+kQ2eEApsSbZlg01fdI/Ds+Xn7WbzmhRGnT9NKDAqP0o/TVnnrKJ7OCtPpS4zW8xv/
         oOb6i8GSxYqXtWPToa/q0MoTXoSlw2jzZKP1qVM4Fjn5NpyXKtbD/nytyQWpuwbpc6rL
         V5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203994; x=1756808794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds6xAU6+uuVJ+pTYkEOyBSf6qVVVR2jmuQi+4247ivo=;
        b=H2fsL8QK0B9XiK9VK3++BRmQ5VJZyHA2Bl3D7Fi4fAg1+BLexlOBCTNxXykc9rOYqn
         XCdocechsu7WzFdG5pv5hb6cXLdFGjozPdGI1674PFHQr0WJPkaWpOf6bfDnXpO00wuP
         QCtpUDi+HDwzh4s+UbHMi/dCcjXiypNbpGprujlI6iaI8I9zuhpc9rWK6/o3zB08Vllp
         6r14Cg9JDg6EaJtEI26YyrkxmihKJ6rMyS7GYdc/Mt2Giz2rZtvt4IMudWYlKblV2nUz
         PXWsw7oHXTFI0l7Uyr4cF+nVupBXI+tlEy4sQ7/tJovQXwHEWM3jzzzv8G3gYhojfuoj
         NvXg==
X-Forwarded-Encrypted: i=1; AJvYcCXzWdlou0ahrMbUKFvG3WM+CjhHAE868IobntrckdOQrE/KHoizyU+NOdtXOaEdCs0BdQSbTl9VBp0rjNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1E1lnJjZahvbtwG2ceCg5kc+FVZUnDOGzcfbZV58UjM5PvNki
	twKBVVlmYwFUZ0OrQ3/Ls58v1BlL9pykHna+NaAcramvC+189R3R8hpoArnQXA==
X-Gm-Gg: ASbGncuTthLgIxbzQGomGSWxpZeGwU979KyJUjrc9u0KFNV7BOHpCOpm1vMOfgNIZdD
	WN3gxisMlXsteAH0b2uxiabwrC1RB4ZqHsW1YiqtoMu81Pu3lDWTm+fWSaxKkoVYNJlbyF0xpFB
	aClxTscLa0brwCFVryo3UDnwVB6cMVywaGbn0ZsjbixBCOHBAN65l0TpVDTgsRxFs8nATdi+Wfj
	/jeUp5tccuu2Z5SiuepWGlQg47yiVUrVLVnxaBXg3AaljhHaCAStugG8SIRCbl0ws1gvgp8GcUc
	7fTcX12PcQFrYAOgXjnkiGl2LuU/QSEIXoh3/zHIpbF0GyUGTFk5h3NNp+FaIErikq8m1+yocnM
	6BiuxKAPU780Km2URpHbuw1AEfA==
X-Google-Smtp-Source: AGHT+IHTceCWbmXAuyBrrQ/rdBMT4nvIUTD87nvmQUP/YtdfJBrxaTfJzojq7oJ8BVjGWCSkCrrLzQ==
X-Received: by 2002:a05:6402:90e:b0:61c:931d:ccce with SMTP id 4fb4d7f45d1cf-61c983b81d2mr876407a12.13.1756203993533;
        Tue, 26 Aug 2025 03:26:33 -0700 (PDT)
Received: from NB-6746.. ([88.201.206.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119f79asm6687862a12.5.2025.08.26.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:26:33 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
X-Google-Original-From: Artem Shimko <a.shimko@yadro.com>
To: dmaengine@vger.kernel.org
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	eugeniy.paltsev@synopsys.com
Subject: [PATCH 0/1] drivers: dma: change pm registration for dw-axi-dmac-platform's suspend
Date: Tue, 26 Aug 2025 13:26:27 +0300
Message-ID: <20250826102631.1891492-1-a.shimko@yadro.com>
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

