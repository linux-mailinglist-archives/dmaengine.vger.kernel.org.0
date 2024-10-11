Return-Path: <dmaengine+bounces-3334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E399ADE3
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 22:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889AAB240C1
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AD1D14EE;
	Fri, 11 Oct 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqe8q6/H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6A199231;
	Fri, 11 Oct 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680294; cv=none; b=LtU4MaCgw0vt1zMLslGo5S6PGedEOzALsi6Bt5sLDkUlQJviXshyOkYFWt/VslaaJez891PyF37hzaGFJUZcqMidyJ7kFpUI+D8n7ihYcA6Wo0HtnPYCxoYcVe9N2ScAJMIT81TrsaWuQadkiXVUZQRaLtsg6qjXYUiMM615iK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680294; c=relaxed/simple;
	bh=2cXz7PTId0mLEo+NskuOjC6q4PQN2Cf9uVvaARQ7sIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oy2YWlCD+7DDPaeiirAJ7YDCu8FWXH48tHaltS0knjzzFHiHbPqxhzGq1q2lxQh+ii+R4UCRbVxFBLeZ/wFoLW9cSphpzuc9JgwG3u1XbUFLBaC1OqzhJVG1eHKbyoE//zsyp57pUv6nog6h7uMxBRQCN3Vr1hwgWHF5K455Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqe8q6/H; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4311e470fdaso9289595e9.3;
        Fri, 11 Oct 2024 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680290; x=1729285090; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uEzHHnWsqAEE4fm8GT4zOCPdwh3SlZj433SAGGe5A4=;
        b=gqe8q6/HEHmESOnqm+Gc45XNzXnyJAAQjVC2AOf62esK3dU5gtlbCShvLI4HS/i3ml
         aXrfUoW7r4QxFUSgB5FwzAmSq8mYNC0nPRarlXTH6lSwSOdNvY2cYFsbja3lqELZt4H3
         oEzJbvKnYVlmnZzn3d89V0eU3j3Ky4tVPvk9J2PAyfVRcweW3dfoQO3aZ+Uda7HGgc9L
         8EjLUNkHfx4pq40c/wPRUYr2kMpIwiSx4XU2NTjiSd6Vg4PSUVqJNtodoNfO1aKrGzs8
         M6SUYz1+QJv4ZbrkoXPoWaBDr3+RJSAcZFLFipPi8FsSf06nHVmVQvdYLSvSmM/8jR6G
         G6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680290; x=1729285090;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uEzHHnWsqAEE4fm8GT4zOCPdwh3SlZj433SAGGe5A4=;
        b=Ta5JlnFfzj1KrMamTqqdCWhMd1fZ+I4j8csNLtYcjx93ctJ4vLfc/cdHKRG9hH3ctw
         atyiLvnsiCJbVvOAsudQn6Rrh5RPZDnrNoDMBXYzPbGX/Kn+3vstsPOX+aTW76Y8oY/G
         NIj/NBoWXQMoW7NS2Xj7tWrqtZhCK9PLPAuibbpMfdRofDlv2ztLf6cFu4j0fpZ/4sFe
         B/v2b8HCBzFlpGxJgtAKMEvkQviDHMrP1ryvwfQ3kvR2rfBCnwVev6zAFG58mJUX8MAL
         E9sGNAY7kTrBl8ZPDMDHx4JLymB+L30FNz1mnflyMcO8hh5EYa++5sg1/1IYlg3uqD5V
         FPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1LToeNIfCNpfduPakZhrZL+XZox1BSgecB1eLQgmljhcd2EDGz0xeithVTSpacXgaXMG5y/6TeFbB8D4=@vger.kernel.org, AJvYcCWtM+csj+G7S7C6LBUKlEVQ1GfingrRP8lUSA/GP0IIoCv6+DseaKrQqxMkQKZ9nOAnP7eq7E52@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYbz8vAnZpK+dpydXW6ZJ/jq5ekSOCL9/AFHOp1i+s//YM9Yd
	7114dWCNwtZgOV+t5cktfFmPpLle6EqYHqvuXSS9q1SfObqCh30jMR5dhoyB
X-Google-Smtp-Source: AGHT+IFtJvJ5UhcaAXiq50kExKavrqftmCa/RSE91ruc2RcDDpLt6I9Vg0nCsmySSiTRMR40y0IE2w==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-4311decaa31mr33751625e9.10.1728680290354;
        Fri, 11 Oct 2024 13:58:10 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835c4fbsm50984055e9.39.2024.10.11.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:58:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] dmaengine: mv_xor: fix child node handling and switch
 to scoped loop
Date: Fri, 11 Oct 2024 22:57:58 +0200
Message-Id: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaRCWcC/x3MQQqAIBBA0avErBMasYKuEjGITjWLNLQiiO6et
 HyL/x/InIQzDNUDiS/JEkMB1hW41YaFlfhi0I022CAqv1naLrpjojhTiJ5pPw/VOmdQd73prIY
 S74lnuf/xOL3vB9dObXFoAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728680289; l=926;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2cXz7PTId0mLEo+NskuOjC6q4PQN2Cf9uVvaARQ7sIc=;
 b=hRFALkGBVHY10VDxR8N0a+DiAS+OaY+0DRy/v6xp6+4WQaiwugfr53UzStNubawsmBqmIZDj2
 WNOxZRelgLfArRjHPF2YKMVsYqMDKfcNJ8qA//22OpimbOJD8haBawY
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series fixes a wrong handling of the child node within the
for_each_child_of_node() by adding the missing calls to of_node_put() to
make it compatible with stable kernels that don't provide the scoped
variant of the macro, which is more secure and was introduced early this
year. The switch to the scoped macro is the next patch, which makes the
coe more robust and will avoid such issues in new error paths.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dmaengine: mv_xor: fix child node refcount handling in early exit
      dmaengine: mv_xor: switch to for_each_child_of_node_scoped()

 drivers/dma/mv_xor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241011-dma_mv_xor_of_node_put-5cc4126746a2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


