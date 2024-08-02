Return-Path: <dmaengine+bounces-2772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BD945931
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F17B22409
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C5E148FFC;
	Fri,  2 Aug 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Dw3RK9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD543D6A;
	Fri,  2 Aug 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585083; cv=none; b=uYAOusF+mL4xpsAp+emLY0TK0V8zt5OvFXjOQgQceKUF6DseOsI1Ivxd98Kjlak94RhmCfgunlWW377kZN3VfUO3LNZRuUL1ZxTKd51EdQjm9dxyNPVyCqqAwrw8Xxaj1shPbwXMp4E4n7f7xywYDF4ghsFCSvMgA/mjvsN8hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585083; c=relaxed/simple;
	bh=IlAxDpbVqzAVA0OkNz8S5B8RxjQK0L8So+OFjVKUXjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SnnWiytY70jEVOKxfUUtxhLdzxNbvufV1Gv9tjfK4UDXZlmmqeuRtHN/831cuvKPmaXC+2pVEptEqwJMU7hhDoE5gmRRG8ezcQdiLe7EZzxe6eoZvSnTw8rfW81XRhnalKORpoTWMuRkyK5xCXQAqb6DK7e5m58j8iKBZdFVYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Dw3RK9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so11436493e87.0;
        Fri, 02 Aug 2024 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585079; x=1723189879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kc1D5G7TPXQ3oMx5UsRQuTJ4qZ5tkN0tDpC8JI9q0Q=;
        b=M/Dw3RK96rU682kCJ0ZfzjyrNyBesxTN6PQdhVKOR3EZ0GDW3We/w8pTxQy/m+bOD7
         b6SqeoIuD5mIH6NwWySvDUbOUwQ8/PaGU3x3NImuan2P4+dA/5UZIbvl7O9/IaBT+IPc
         wU/i9PwemAhU4mHyfP5mTImaXYoRkFvULBhhJjkvzgUuU8l7oDN7vI0SnYrveBKK4UMs
         m+8omxXjEXasfqQ72lsAfS+8jNI7+7XzC5EoUjO+V4xsErMf+YlgA+aeC0jvkvsBdRTq
         68bywxT9l4UyZ9vkM94R7lfXoXT0zaeyHuz4VUI5E8Us1NBhG7MDscY7fEBj4ef3SF0L
         aHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585079; x=1723189879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kc1D5G7TPXQ3oMx5UsRQuTJ4qZ5tkN0tDpC8JI9q0Q=;
        b=A4/MG+AMhn436uKmgCwKC4DPLwHZjlsoUc0XWyw0nvS2UGQDQExSrZ65/R25cQSzKN
         YLg2bXOPaTqqGeBDvo1xDyvsE5wihLi8hC1qBEuzpQ1tT9o6IcnvWjSvP5ayHRR16I4M
         x4aoZ84Gvqb31Ki35kd0o3TR/lV8GxsEYkWJVP+O52LQXvqzOZhB/uIQct0fLlQh12ML
         SntlI0B9CyYPAW2GqldR0K6pdJF414V/XiFiDHf3SN64MLOb82mA/uFGYbhQMs+cqIw4
         t0Ey8lQ7SD6qnmaiqNPSRWshlcLU4YJJuH7XIXllSetvYrLTa1+L+HV2p8iAjwWei8Ue
         tkIg==
X-Forwarded-Encrypted: i=1; AJvYcCV1JS95afBqrJDxF99yv8WtjSC1BryjhEG67MmO29WyO6BlAh/ABk+5CVNFqlNRr8CgBnmDlNWvy4Sws2fa3MSMNCjU3sGmWkhlfuNPqrHwXH0B4SshzHUD8WlM1ToE6J/XQpEGo4M3C/uMKLextx8Ct7WfD7wlFLSM4YbkXQKkKC0kKixA
X-Gm-Message-State: AOJu0Yy/S1FvKdxqn2tDBDSsEsKVrZHRv7gqO+g/GGh/TwCSVUHtwgTO
	9P2nDjySk+p5dWkCWLUZNxDWclgYxWizVCwWk/1H3XDz0iIR78yK
X-Google-Smtp-Source: AGHT+IFlqHEfaaG4xUfqTDoe8WnMb+Q2hWN1L/b1lxYGa0jq8iYnl+Odghy5uRk2PUIlQZdLswWZSg==
X-Received: by 2002:a05:6512:3d89:b0:52e:987f:cfe4 with SMTP id 2adb3069b0e04-530bb396e7amr1392918e87.30.1722585078900;
        Fri, 02 Aug 2024 00:51:18 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba35219sm156304e87.192.2024.08.02.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:51:18 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width misconfig
Date: Fri,  2 Aug 2024 10:50:45 +0300
Message-ID: <20240802075100.6475-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main goal of this series is to fix the data disappearance in case of
the DW UART handled by the DW AHB DMA engine. The problem happens on a
portion of the data received when the pre-initialized DEV_TO_MEM
DMA-transfer is paused and then disabled. The data just hangs up in the
DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
suspension (see the second commit log for details). On a way to find the
denoted problem fix it was discovered that the driver doesn't verify the
peripheral device address width specified by a client driver, which in its
turn if unsupported or undefined value passed may cause DMA-transfer being
misconfigured. It's fixed in the first patch of the series.

In addition to that three cleanup patches follow the fixes described above
in order to make the DWC-engine configuration procedure more coherent.
First one simplifies the CTL_LO register setup methods. Second and third
patches simplify the max-burst calculation procedure and unify it with the
rest of the verification methods. Please see the patches log for more
details.

Final patch is another cleanup which unifies the status variables naming
in the driver.

Link: https://lore.kernel.org/dmaengine/20240416162908.24180-1-fancer.lancer@gmail.com/
Changelog v2:
- Add a note to the Patch #1 commit message about having the verification
  method called in the dwc_config() function. (Andy)
- Add hyphen to "1byte" in the in-situ comment. (Andy)
- Convert "err" to "ret" variables and add a new patch which unifies the
  status variables naming. (Andy)
- Add a in-situ comment regarding why the memory-side bus width
  verification was required. (Andy)
- Group sms+dms and smsize+dmsize local variables initializations up. (Andy)
- Move the zero initializations out to the variables init block
  in the prepare_ctllo() callbacks. (Andy)
- Directly refer to dwc_config() in the commit messages. (Andy)
- Convert dwc_verify_maxburst() to returning zero. (Andy)
- Add a comment regarding the values utilized in dwc_verify_p_buswidth()
  being pre-verified before the method is called. (Andy)
- Add new patches:
  [PATCH v2 4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
  [PATCH v2 6/6] dmaengine: dw: Unify ret-val local variable naming
  (Andy)

Link: https://lore.kernel.org/dmaengine/20240419175655.25547-1-fancer.lancer@gmail.com/
Changelog v3:
- Rebase onto the kernel 6.10-rc4.
- Just resend.

Link: https://lore.kernel.org/dmaengine/20240627172231.24856-1-fancer.lancer@gmail.com/
Changelog v4:
- Rebase onto the kernel 6.11-rc1.
- Just resend.

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (6):
  dmaengine: dw: Add peripheral bus width verification
  dmaengine: dw: Add memory bus width verification
  dmaengine: dw: Simplify prepare CTL_LO methods
  dmaengine: dw: Define encode_maxburst() above prepare_ctllo()
    callbacks
  dmaengine: dw: Simplify max-burst calculation procedure
  dmaengine: dw: Unify ret-val local variables naming

 drivers/dma/dw/core.c     | 131 +++++++++++++++++++++++++++++++-------
 drivers/dma/dw/dw.c       |  40 +++++++-----
 drivers/dma/dw/idma32.c   |  19 +++---
 drivers/dma/dw/platform.c |  20 +++---
 drivers/dma/dw/regs.h     |   1 -
 5 files changed, 154 insertions(+), 57 deletions(-)

-- 
2.43.0


