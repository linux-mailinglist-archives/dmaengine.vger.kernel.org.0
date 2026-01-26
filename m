Return-Path: <dmaengine+bounces-8498-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIRABApFd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8498-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:42:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B087256
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA0353046A8C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD3331A70;
	Mon, 26 Jan 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/+s+veM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81370331A56
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423827; cv=none; b=HS3LxRYr3o0KeI3L14PLBNMNeLzSC2tUfPqaORg1AVj3gLyxwQ7UJdUYJk81zSutaK1SYAceaPNs+JViLEI+jU+NYIQvfmxKNcRwF/q8GOA87109sLf8MWIZWBD8xhX0M5Zo/CgT3lQ2N6ya9082WKsIq1CWR2EtkWQJSXA/qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423827; c=relaxed/simple;
	bh=pznKSkUwrSLIJKx2QQJ4bcg8USchknuhaXCCvMjo3kA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In0o8YfKVuwPo2p75QJqKGTaCGif0wwkHxGh/v710LPwKCA4+JEgJ2Y9D8Ki3qkeeg1RMkfH2jYKjYQh2bu10Sypv5QrFvojLBuablhnOaHozP3N9XB1R8IJbg3+UTY7g7WFNdY/7/OO9Rj6C1dnDx/qdKl2ozpgbP+QWCSx9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/+s+veM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09d981507so29107595ad.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769423826; x=1770028626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bP5CKDJN/blg0QyqYIlHPTsMMemP1Vxj6jhKUJGLBI=;
        b=h/+s+veMP2udSl827YbhiEnMaGfYbXB/X2HLGBEULmPlTKKOfGA/HhCnrk1DJHoFYs
         Ubt7dhTd92ot/DYoIipaZ5nZHx+ChBmzGWoLr1dj8YQ8l3gRQhKerpGx2tssx+3C2jLY
         Gbt9RevPBBnWIskiyiB9tmAMRSKI3NMurli5yhmQG9Sz/32mjPJdB85LGIaUXvytqcKe
         gSDQVH0g1cJAxVuyVYfnLS6K8m/YygPTpXn216b9EU0dgIIrUGiif8OFOq4MigNPkHOc
         TEdXd+ge1y4cW+Fk2OY/ytpEtNuUwzj+g5cFe3y1DjNY3SfQ0H07q9dzdcEqpt+g5bTb
         M+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423826; x=1770028626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bP5CKDJN/blg0QyqYIlHPTsMMemP1Vxj6jhKUJGLBI=;
        b=dRIZAqNqHh7s7y7xSadIJkSbVwOc4T7Z7RvVtKIAgf9hFIXNAuG07oym5hSeWn4ril
         szHJsPSK8ILAtIwT/r58KH/+v+fKi3zJjiTQA0p97Wv8int/fzI2aQ/iTQzaDxGrT2DO
         5sYuyR5ZKopqHEGoC7tBIsjkQIFrn3QtEpL/Ui0W+BQVm/pM9UXsZlBDSsI29BTXFXYW
         v6uPNfDSXI4saNKFcByRd/JtvZGZmjrlwv77YpDzhGbJtaluDxC/ti9vhMFDGC8pOdVO
         7oPytT9uq6SNKGTWZnllQdBbLSpxcOgGhOe7R2d4JAoBmJFZitORVitIm3zBA8vdXMKF
         4Itg==
X-Forwarded-Encrypted: i=1; AJvYcCVa0gqh5cbtddurzmvGhhVP7R41n8utUwYeFO7AYFweiUsjAA04I+e8Kcqm60Cbs6sqVcW7/ym5Cag=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRS8zxtu6PklYgkhs60YAMFdH+rGWmlCdBGAMcsY/bt1J9YDT
	axZBmf+4Wb15qmycinCt4XEsjAlI7xo8hZ6El3H7gL70E3CeTI6MIDSw
X-Gm-Gg: AZuq6aJFJD3i0H9Er9j7B+tLibI7m+MZy07sJVy99xLFGil49YnngiuTu4b6d4lVC7M
	tvm0OLbpuoi/Fkd0ugkUO/smURBhMKB7e1n+bYzU6AT7hdSfP76qNtuSLZvlSwHNqEkuX2/7lER
	paYK87LvZRbGsR8iRucXSE8opN31OfJ9y490SicTJrX6wbh9xk+oUgq93niFhYsaayItrXFX3z8
	M07iL6pIgO5p6q4LTcBPK9W5yhScUiAXRMB8vV42taQZjt2MMWsYbQPFOhq4MLut14cB8Js5dnE
	yJ9j2iN7X21ozNUfzXBjjmvvRNzfMV/FW9bRJ72zmLYFbiZFJkOC0oj4D2zNWRKevqEciv8BpQk
	aWnIdQOdekxKdeKhayVEqjbQwRtxQVMWSRmSQavv1J2Tjz6L/oeWzFr9ltmhfVkrI3XsPqAnCE3
	Yx4jSjFyPaCrkHvGlFZQS0jrfRNWp2B+NnbdNjrgkbS+dHzw==
X-Received: by 2002:a17:902:e892:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a8454bd0b9mr44709455ad.2.1769423825751;
        Mon, 26 Jan 2026 02:37:05 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f9762esm86827545ad.55.2026.01.26.02.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:37:05 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v5 3/3] dmaengine: dw-axi-dmac: Remove not useful void return function statements
Date: Mon, 26 Jan 2026 18:36:32 +0800
Message-ID: <20260126103652.5033-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103652.5033-1-karom.9560@gmail.com>
References: <20260126103652.5033-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8498-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F5B087256
X-Rspamd-Action: no action

Remove an unnecessary `return` statement from a
dw_axi_dma_set_hw_channel(). This resolves a coding style issue introduced
by 'commit 32286e279385 ("dmaengine: dw-axi-dmac: Remove free slot check
algorithm in dw_axi_dma_set_hw_channel")' and ensures proper function
semantic. This unnecessary return were detected with the help of the
checkpatch.pl analysis tool with --strict --file option.

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e59725376f8e..c124ac6c8df6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -593,8 +593,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-
-	return;
 }
 
 /*
-- 
2.43.0


