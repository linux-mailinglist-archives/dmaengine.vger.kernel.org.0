Return-Path: <dmaengine+bounces-11447-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hoNVNWRTKmq3nQMAu9opvQ
	(envelope-from <dmaengine+bounces-11447-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:19:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669A66EF7C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:19:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RFNrmYDF;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="OLOna7/q";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11447-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11447-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92341313FC49
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F418AE2;
	Thu, 11 Jun 2026 06:17:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41935E1C8
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 06:17:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158659; cv=none; b=JRoYmzZrflIM5TdDwSxwL2iAOmuBJKdNytCIAGGjWysOKW4Ma86KjzEid8cmSzDbaNVsgBWK6usxwHj8T7jsJ1HcisOZNjaNoN2ERfkCNnihXuNvY0onqCjguefdSWtQSaRw6IeaIfKUaSrUmgD2m+XWl24tsSNAz3CxdGOR8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158659; c=relaxed/simple;
	bh=WhO7STJOA8D0l2Vuh6fV22xQKvjJKG7+GebXtkY8kOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KVxG2FKQdeEZya4mIjZGBeo3At48OEPsLW9BvWUHgqFR0r7s00hZyit98ocpl8/L6azttl5Fd4g9WN/88cFw/zfv8/BhEqnIxEsTIOVYfDixQtxJuX/2m043jGbXX0dLmGOnITsBaljwLWZsPqH+9MbF7ntOXm81LdbFr0z5oOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFNrmYDF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OLOna7/q; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GSaq3843874
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 06:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o10CKq4aPa2DYF3tTfTo8W
	R1LMgRsOFFz3wb2DwwM8o=; b=RFNrmYDFZPBXEhM6T2tkSwB2dfqP2DcwvDOjqY
	giNOiD+rDsoMxIRp0QHxg/opNomlJZp6MX3Mf+rlqSfsjw78PlfwGk2g4NA0RMxq
	EAJGgiSPSO1ATN+XRSnH78h1TlqQdpgb01Xsd0TEvZdH2qXS0UFNOOqa8AV1sqrR
	B24A8ZMewoCvyQeNMgre5f7w31Z1Re5OtfSYeukAwEqhuXFU/HED/l8PcbYztXZB
	aPXIisVjKlpK1sHyhs4/6pWzSQPpMT+fMABF40weZcHKIQIVMb8SV98KLlEQxm9X
	PONp7iwZ2UQAM0LgP8dTq+FstAmwwqrltZiMCkSTIAdjCu2g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701whj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 06:17:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2beff6b6e74so76938385ad.1
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158646; x=1781763446; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o10CKq4aPa2DYF3tTfTo8WR1LMgRsOFFz3wb2DwwM8o=;
        b=OLOna7/q4ihL8qoeaeDhXcEGeA1ak4YmBBpajavW/DUnKbB/pLqb3Dg/MQJsoGmHyD
         /GxjmNlIitH0JGFc0mBpzbtWkIPHE8+DvS+1xLN5PWxcPzgegUU7/yLlKkzQjH0tYh4d
         C/wKpH+ycGrKO5NadV2Rr/sa31RN5XCUNPRQghoHN0mCWOpcFi7QieS/tsGe5Y7TSz2s
         T+tCnCy7Rp7V5Y2OBbdJxzbiGH2/9Nlpbr8yrSmd8s0/dzILMgMepPvLsWBymqrgN+wG
         K0a2vogx+LSh5FJBdzfywjw+CVH/E6anqAortrXLSfSXsS8ZeeH5NPuQZNOxDDsj3PXk
         18ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158646; x=1781763446;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o10CKq4aPa2DYF3tTfTo8WR1LMgRsOFFz3wb2DwwM8o=;
        b=OkilTnmGu47S4t+LL3yRoVOUyCcRHAwCclXCIGI4ft/Ci1khOBgTf6OyMwIm54GbeD
         I6IqiVKBeg1NHUEk0N/FErx2cCHpPn5hPTl58OZOs9LgiwCr9Yl2dHgCAU0NjNjQ0N5S
         aPHajg8VZlRtoJ7SLIywtrDUjqjsw/Vc4IpG7iPEpJCDNOI/D2/v5VkC5oT1pYg2TJ+q
         9d3Mtq+gC4kqB3mVyuTgIYjrVYZhOVPnWJwYMDxusJ0gABnif2P9hlQXL4wy9jvGABFJ
         +kAefMxHO0bXQrDLfo1UhluKUniscjUTD/zeDrDPS9IcNmKtQEs2IMNmG17pgMfjS5cu
         GeNg==
X-Forwarded-Encrypted: i=1; AFNElJ8MUQq2gzJven1BUAgFMDna85bPDuJx8dJkjoO0tnfKgV4T7ehl9M5pPYhQZ6VWaIm9eSUR7JYAwN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADuXk87Lr2xBKtcQFOKzElSZfb5CPE3Ykk5NXzMsUvlbxfR7k
	D70MvQwOhRy5BBEcwTnZxVHZWFD/PVhLz8DXdXQiJzDYAyyuWWJXD9vaGu/ictHHFwvI3qm/js5
	3gaa0iT54W1qorR9PXCe2yHbnldLQ6mgEQc1LafrZXD+8qe55KdVAMmjtHPsEcno=
X-Gm-Gg: Acq92OF1l8SZkG8ZV8rcAFUk+gfzj7EZuysVWDdb9x/kxlX/TLcdDXrGcmHPKR94w39
	CaCNIiHJkYl1IkBFMEThHFo5p61/wNpscysU32d/p4Zf5ySyYm9MlgHY8kDb9g7jDF5+mnEX64S
	O9Tz1eWM44oJVUuxHC53bcoFTKQXkGXeQ3SyYzB0lyVvu3Z+ib3j7gYO2LBxwc1TXKBUD/KeYbn
	9cjnT/sdZf6tgCJLjrrXp3XN2wczbZhkeKreAAq7xaQWCB19O6yhprc/TjjCacfbwxBIlGGnzFE
	6Z299jMQSgys9RtZ6sy9wVNxryz2AV8OLVUXH5J0TZ1lwVzzawncHaj0HcLEZV6Z68WTTEfAY8+
	6MhOxo+MVYZLE9VrJpnCOS/vCQcDiaDhPk+iXWFtLgn9wmUqPT84p16VNM5FSUQ3ZZvAf
X-Received: by 2002:a17:902:cf11:b0:2c0:f807:a760 with SMTP id d9443c01a7336-2c2f14f6cc3mr18313725ad.13.1781158645813;
        Wed, 10 Jun 2026 23:17:25 -0700 (PDT)
X-Received: by 2002:a17:902:cf11:b0:2c0:f807:a760 with SMTP id d9443c01a7336-2c2f14f6cc3mr18313325ad.13.1781158645328;
        Wed, 10 Jun 2026 23:17:25 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm17015365ad.77.2026.06.10.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:17:24 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 11:47:11 +0530
Subject: [PATCH] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device
 tree
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-qcom-bam-dma-irq-trigger-v1-1-21c216e00b2a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOZSKmoC/42NQQ6CMBBFr0K6dkiLWowr72FYDGWASSyVKTYaw
 t2tnMDNT95P3v+riiRMUV2LVQkljhymDOZQKDfiNBBwl1lVurLaagOzCx5a9NB5BJYZFuFhIAF
 9tJZqutje1CrrT6Ge3/v0vck8clyCfPanZH7tH6PJgAG0Tvfnk9Mt4i3EWM4vfGTDlzlUs23bF
 6T7qfvHAAAA
X-Change-ID: 20260601-qcom-bam-dma-irq-trigger-0366e7e86f17
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781158641; l=1659;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=WhO7STJOA8D0l2Vuh6fV22xQKvjJKG7+GebXtkY8kOk=;
 b=h2QQISbvLM5eEow5NQq5013lL1LiyZvy1/IV5jqHzr6Jdeq7AjdPvThChUCpNDQbOG7NljAfh
 zWff99S4FnoBOy3Do85tEPlD0fhG1J7Cgr334S33Kr17jDIKD4oJ/FP
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-GUID: niZeSvU2OZTP-gZd17XFSsoRdoJODzfm
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a52f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=l1n8trSoVLBZuIMzfdEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1OSBTYWx0ZWRfX9Bs39pBINey8
 f0Rax3yaLS9wYlB15aHA8VjaFdyKrixbPVHecwlekZ7M1XNoRB4/H/ucJCY/kE55Bv5pr0wf2gS
 5DUc6EzbIJ5UAo1WyXKSbYxPfHDqti/74ZlkNd/wR5L0jripUs7pJuFvaQljk7wEuseZABeIFpS
 0qjZymR/zjlG59bfVYU57QPHT3QGqLX4kAZBZchIfU0S84m0a774A/bsfXYT+KR5jFU28JFK7LL
 3nlamB2VD9ULsGkMzdJwmzZOKFql4REzatNU3sdwiUcMxklPvICJBEJrXelfEI2pLAoyXTei1YF
 RHJg5E6Eylsz8Sn/dY8kkZ5uFwaNZffLdCxfvOdKmTJmUkmuXdRuicLLBz6p7/qYwhsGeXL3gdY
 e+I9zWYRoipKGl3gT5v/isVHOLsxwnrFHGKNhHVzzH7n9cQ8A+rY5VSgCOwkUHWcMFCAbq+HUhP
 e41Gy6dDO8fu+Upkgng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1OSBTYWx0ZWRfX4+V9lrrhY1Ox
 pPYZCzMuGbvWycmFqSF/Dl8WlsZTW/+WxqAkb/TkuhIUTvyERJR7HvyO/cs2XGC1IKpOBikYeu/
 n/H/1XITKDMgafjW/t+zEqHGj2BQEjc=
X-Proofpoint-ORIG-GUID: niZeSvU2OZTP-gZd17XFSsoRdoJODzfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110059
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11447-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2669A66EF7C

The driver hardcodes IRQF_TRIGGER_HIGH when registering the BAM
interrupt, which overrides the trigger type specified in the device
tree. On Qualcomm Shikra SoC, the A2 BAM signals an edge interrupt
to the apps processor; registering it as level-high causes the
interrupt to not fire, resulting in missed DMA completions.

Use IRQF_TRIGGER_NONE instead, which causes the kernel to use the
trigger type already configured by platform_get_irq() when it parsed
the device tree interrupts property. This makes the driver
platform-agnostic.

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f8325767a0d97a7848077885b118241c..6c3e2ca8a572fd04c925de0adbd5cc0616b361ef 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1303,7 +1303,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 

---
base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
change-id: 20260601-qcom-bam-dma-irq-trigger-0366e7e86f17

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>


