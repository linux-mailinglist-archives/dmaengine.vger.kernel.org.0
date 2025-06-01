Return-Path: <dmaengine+bounces-5291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4CACA09F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B47316C682
	for <lists+dmaengine@lfdr.de>; Sun,  1 Jun 2025 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838D23959D;
	Sun,  1 Jun 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlvQivT4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94E1A01C6;
	Sun,  1 Jun 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817768; cv=none; b=PLkgUC3GOyrZYUaP0Ow8+U5YqqaPqvKyf49CIFG2z/mxDNlPK9yb1tuWpTgaDiaKKOnsvQrHYcI95eLx8RQZxbnTiCB4yOUocA9IrpmDkddbsUZ+YVhCGwDxqOSyXddt9tkeHDP43bUET/R9EeRNWXw8tdrhFAAk9KgCm+g/Pb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817768; c=relaxed/simple;
	bh=fSUbC8ue5xuoYsPPCkrjhijoX9CUVHnmAfX71mfqU94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMO1sZh1cIiiVs1BGBck/2t+nypS5oW3qF7DLNFmN4mQoTtW00B5B3gVGgV+GLwNK4KF0HSgB9WzcpgwA3Gn2k/lu3u96GvZVkPZnfpGBhKpY03EXk45bnMrHYL0+oh/+MMgIlhtZ+VH08mGA2gblGR+A5xvQtNNHIEGFQYkv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlvQivT4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d54214adso6825985e9.3;
        Sun, 01 Jun 2025 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748817765; x=1749422565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SF7cA4E9BN3hkPat2YYsHMJ+T/3Iu8BTo2+5VoN0ds8=;
        b=UlvQivT4UHQsaol9ylnCFJhDUFHlaFBiivLP0v3fNNfCynIyvKvsuZjwZJv8ZwOV3A
         VxoUXXB6+9JAZPIn8pWXyn2nxOQ2pGRoH8wdospIA4kxiPtiQsVvIfqQDWKVf90lw71F
         m216vSGPh5idJWpn6hsZ0rcE0O13FGP9CgJ3GnGjy1paOIFEbyOwd0h9v7O+95WXOsHl
         1IuDqCQV7PwSvUQNsbb04KyUdm/OsW8v1pTEbPo5b0GosE7h1Oj5+u+SJrSKhuNYTZne
         w1ByzMDrbhNZFZFpHOcUxsawoRqSZ+MkhwWk6MeS9ptdJa4q7ItPxbtFvCTLuyqBmCv8
         pCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748817765; x=1749422565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SF7cA4E9BN3hkPat2YYsHMJ+T/3Iu8BTo2+5VoN0ds8=;
        b=Crrs8nLPuAwEJOjM9fAgSya793xh+GRzwwE2Fz5rejWVUXDEOT3UWbmR/cR6pCvuHu
         ruhhdWKDPyxogyg11Eq/lOJ8LSSlTSYQsKPOw8t2N3ibxB8ZbbLe1ELa7UsR/OiRqJA4
         Ygkw6RcudIr8LfuGWk4No/Gf0W6Z4dK+E7OjmJD+P4Sc6HqEAdAe8kIcuPoJtfqru8Ty
         zACbwCFC61GT4nakibRoutsBea4P9bMBjgWsG+Zn7Qow6Sl/PfjbZac+7hTnmtSMcgVF
         5sMQYdcvkJlI1yJo6Z2JqOdyQ5CBYhwuNiUhDBAw1leXufv76eOrC+/pWl6gqh/nWfqq
         /5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUGZMK74TZNoIEjxYT2DN9YpeKK/Z/sq2I/JBQslSXYkQDv4jPPQoFIsch3AmX/VNENJmqkkBCIXqO0xe9t@vger.kernel.org, AJvYcCUJM1wzoP1mSBZ7DNOKWpmc1P2DdB5GcpTP6W2DJQLQsoAtqUs7IMkcr12LHdLX8bMENOJZE6jWeKox8cfJ9A==@vger.kernel.org, AJvYcCWfJwjc29hUfOmOmnxyiJkfV1vAzLJo4Oj/+Yx2zHpg8YWcmhrCB1TNsGA4uCH9pzjb1rbFKkX9TDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzecPG7nOYt826GQ4FA2MImS/W1t4cyUR7cCkkWmdztuYphC36j
	QWuh1hNJxYziFhgzts4gHVPYNKDSRLMc7nDnsLyEb3+jIjD605glSx4b
X-Gm-Gg: ASbGnctgk8pbVCwJTUOWSZJJi5cmXnCuSzZe4oJkA33Tf05Q0OpYj46xLtEJCkfRTN5
	9HCc0U0PbbuhUGtQiE2MXem5dr1t74vuAO8i0Oqbd6mu+LJXTaNBUVdtaDtptEQB+2AnPQ8mVW2
	7WTUV/hwDiWvSb8v05Z3CBrej8Ir837AcXFtjKV+xLA0UjH25BfUp+UPg/ApCuQk5w1ejQ5106B
	nnrJ64jjKbCbdc9UsRCi3qY4mcuuouq39fiHjT1s9/zJC69mSMOOYRa7hfCGMG0imz3T2/RxDRZ
	dh240kqSbDz0KwU0Gk9NxFAuC9z6+p+ftRUAcXiZN39LrKyu6mtd
X-Google-Smtp-Source: AGHT+IG3zYFoACQN9M5H7HAo4tuvdifGw7budMeC1WAUHcB3EAdv/pcs7cNuCuhFCjbc82yl1vfYew==
X-Received: by 2002:a05:600c:8207:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-450d64c1bd9mr91267365e9.6.1748817764868;
        Sun, 01 Jun 2025 15:42:44 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:4518:757b:6751:290f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm12916554f8f.53.2025.06.01.15.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 15:42:43 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: Sinan Kaya <okaya@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 0/2] dmaengine: qcom_hidma: fix memory leak issues
Date: Sun,  1 Jun 2025 23:42:29 +0100
Message-Id: <20250601224231.24317-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix a few memory leak issues.

Qasim Ijaz (2):
  fix memory leak on probe failure
  fix handoff FIFO memory leak on driver removal

 drivers/dma/qcom/hidma_ll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.39.5


