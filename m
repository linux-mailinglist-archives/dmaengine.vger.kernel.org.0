Return-Path: <dmaengine+bounces-7338-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E092C830DF
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 02:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D065F3AE8A9
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 01:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0516F0FE;
	Tue, 25 Nov 2025 01:58:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2786348;
	Tue, 25 Nov 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035938; cv=none; b=mqmjwCEA6Gl74oz3gTYDmtDs7bmztgZFOpjbg3wdibMEDjqknW1C3kIanFqTd9Lc5Fr3Jw3Z248JS0dVf8m4ztigWxDN8LfHt7tBJ4h7Ouawh6XrXKziXULJQaa4jSDg5u/1ew9XHVtgN+c9DlxCT98oIw4l3jVkJlGw5hvZOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035938; c=relaxed/simple;
	bh=+OpsxVyUyJHH+eHA3boHq/Abn8n6f5tdwAvWdwWrphY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RH40Eu5vZPQqWyuD9xFJHQytiMP9e5AT2C3ZEv+Ox+NHtRo5A+I9burYpHLLcWl/8lQV0uw4tKB+pXMxxtdTJ1QRu8Fg5INoelP/cK/AYcrG0bvEnt9AGvv1FUPJ54wNUfbmYW555vLmmA8CRRFoAi2/+mBet/quiJYodDuqFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202511250957395201;
        Tue, 25 Nov 2025 09:57:39 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Nov 2025 09:57:39 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Nov 2025 09:57:39 +0800
Received: from localhost.localdomain.com (unknown [10.94.14.191])
	by app1 (Coremail) with SMTP id YAJkCsDw_DcTDSVpzwYFAA--.132S4;
	Tue, 25 Nov 2025 09:57:39 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] dmaengine: pl08x: Fix a spelling mistake
Date: Tue, 25 Nov 2025 09:57:34 +0800
Message-ID: <20251125015734.1572-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDw_DcTDSVpzwYFAA--.132S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4xKr1UJF17WrW7KF1UGFg_yoWDAwc_W3
	48WF1xXrWqkFs0kr92kr4furyIy347uas5urs2qFW7WrW7Ww4rJrWjqa4DGw15W345CasI
	yws5Xry8C3W5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbw8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?FuP98JRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KZivRmC0PSImeEoOF8OOobtcbS5HqyPZ5NbUv4I72y9QPyqmUyen83la/W4dufjGObr2
	II8rX2CJr+Xpwh1KRUo=
Content-Type: text/plain
tUid: 20251125095739fe1863fd41d115dd36d23b8251d0ef87
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

"Accound" is an archaic spelling variant of "account". It had completely
fallen out of formal use as early as the 17th century, when the spelling
of Modern English became standardized. Here, it is corrected to "account"
to enhance comprehension.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/dma/amba-pl08x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 38cdbca59485..3bfb3b312027 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1010,7 +1010,7 @@ static inline u32 pl08x_lli_control_bits(struct pl08x_driver_data *pl08x,
 	/*
 	 * Remove all src, dst and transfer size bits, then set the
 	 * width and size according to the parameters. The bit offsets
-	 * are different in the FTDMAC020 so we need to accound for this.
+	 * are different in the FTDMAC020 so we need to account for this.
 	 */
 	if (pl08x->vd->ftdmac020) {
 		retbits &= ~FTDMAC020_LLI_DST_WIDTH_MSK;
-- 
2.43.7


