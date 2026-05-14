Return-Path: <dmaengine+bounces-10468-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEq9DExmBWoZWAIAu9opvQ
	(envelope-from <dmaengine+bounces-10468-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 08:06:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F853E316
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CD53034ED9
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C63AB48C;
	Thu, 14 May 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9d3vKN3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhOzAQ2c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D43AE1B9
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738735; cv=none; b=VkBFc/5/dpsqciwACUH6yhrK6BV/c9CpVBppzYf5lv0YVla3ZRq/b7dGgAIfIBWYQ6YiB5ie92QKfWiZzqcOVLwdpf9BYmRETOFHNGhpDOs1lfaFpO64LzCeAbXh/tlQziga5DWyd5Xfqh4BnG4ut3ZunE8340JI+YeOP+9A8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738735; c=relaxed/simple;
	bh=sfLQhQwFGpTeogFBIPpVZh0bM1trgBhBsW8I4eM8Xng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLpBKWSujIGprR7LP/PdayXyoE36yrjuS0R+h5Gt3nRrGN1+zq+JbMA8E+sBnmhnMYZ8xeaqWwlA2izsIrxYoQ7gfTjhwqOikpYexc4ONY6BSBWyQYSYr0fmTzlzoMmSyWVDqbEMb7Ajm/EZYtN4flclyL8kf0HzSI//DbckcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9d3vKN3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhOzAQ2c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E56mh2828347
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NKZ1yNxecwzk1ARo+imIXjA4pi6YLl/Pq2B
	diROAYPo=; b=T9d3vKN3D1YHGlGSs6Gk5LVz1otIyxk3RNjF+TPtITHJHHIEOsK
	0iROJ0uA8U6wWCmUJ++ofP2CKOrvf88mSiS8i9dA3+AxzZpwLfZy89CCUqxivbFn
	bAr9TXx+9ijBJW2FbxoB6O9vI6fhqZKrYeBnHzH3Sjs6Yo4XR8PT7uMlXDMTxrl9
	RU9yyxyYNnJJyb46Q7WEpjFde7YGSpwGRsuDVLiZ+obC3iPa6BonITpgKQrOxmVQ
	Qc5ty4ndgwSeTycMBJfvx2dqXXl1WrPmtdxY9ijhkHXx+w63Ifc63QPvYqEfxgVw
	VbAvHzttL0l05JTcJrxpiGD5myLKp9tEN6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7g5eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:05:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50faf575af4so174025271cf.0
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778738732; x=1779343532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKZ1yNxecwzk1ARo+imIXjA4pi6YLl/Pq2BdiROAYPo=;
        b=FhOzAQ2clXsiVInwsgf1Z5GON8yAxRcy1HRfjfNrYUvWHqTacQJK7nkVkaNtcRa85X
         a/0l61ppV0SnlqW+Y3rMmlNEMQarwqSZeQ6yk1dQisjJcGM2GeWKfaXVg7QSa/8lBi+Y
         5Hb8QEJ8gRPSkjzOEr1gSAVzUtp/C5//qyYs+eJb/8/haVaAcMNG9efsP7wz7Km4ebAl
         iqQD267C76efOV9bDihW9AZW/dN0myq50EPTIAYa4r7VokdXY2qogO8sboFAZTXY5UOE
         8ztCrSA0VrX4JcBQijYydh3XPy3msBcvNs7aVlxYizktP705OZ07azzaIdBKQ1uI42vp
         dSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778738732; x=1779343532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKZ1yNxecwzk1ARo+imIXjA4pi6YLl/Pq2BdiROAYPo=;
        b=qTEqj79RAjOpMHInBP9GgYnHSJTdARvVYJxnIRl8Q491mJsvznbj8Mo2hVYeRN7wvg
         T11WPFRW3AvOUOX9/02ZptHOUSQHmCCGg4Nigk0Wrgp2vDzvFoPFJV6qw9kgDVHBFlW+
         bz/oBd1r0gYmRvsVmCf7EJW+vuUSMqfe3r0XVgDMjgm5eGTSkMJtLFlR8R0cANo5qctr
         CaYNaYc8MbJiwZpJp7PP7K0OrBSODDcjFfAiCB7oP7RUienYimL9AfplccWnpiTqvY8h
         n64FCF82fFPYDNUhNR5btrgSqqjTmk44WxJZUxaOSKnCVdN59iQw+ddVnKpsAaxgp9xq
         o7Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9+Cf5zkXqo9wL1UTf8p03AiuK1icKj6hxbII4RJuL35/GCWyhaVTDCdqScVjYhFwxos3hCZUa/HJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNLZoFJuQqD3k5ixPnTXiTcUNiYifexMkeRs8POcHN2LMS0vS
	Bep2/LIwZTlVpBTcjIV7rGUtb8iPNt7d5j+i8a6ge4n1Wfc1rEa4EqJ2VqLO/l13/xbUs6OMOgp
	j+QPo1OMBRN45PdcIRJKhMmY0XfMpuPczuA/YCBZuAsprf6PasQRgv9UX15rEJ6s=
X-Gm-Gg: Acq92OFQa1Je8+6FKoRPBqlpQahUDDdvrm7j8fosfjvsfyIbnoxyLM+dOAAOT5q4euV
	wBqq4TG9a03mZncdMzd1Uk6EBc+5zcfJYu/uhW4/KLuntIFRj92G+DjStruEqtWEDKzzXuRlGgt
	SoqgiqyLYZMHCRHW14qaCTX5mUf+9guY4KNhvySTfr4VOrgPeDQ42oqEnis4I8UYHfDhfLREm/O
	sBZbC8/FOLCCE75c5yWefJXBmIyDaAP7xwUneaJVqUwHwDlmuVaMhGGrR0Gl3Tvo/0jZ7fN6FBt
	C8bqE2vi/zvRS7sqkxOU+c01TlWkyN1ISksyidiurSNagSmt3DL6pJDxq5IfVN+6uBn+elXL/h1
	jVBJu1kC6vILwPCoTwh3hffd9sRnui8030+4WLZg6xAnGcbk=
X-Received: by 2002:a05:622a:2c7:b0:50f:bc57:d69 with SMTP id d75a77b69052e-5162f2b77eamr86175661cf.0.1778738732454;
        Wed, 13 May 2026 23:05:32 -0700 (PDT)
X-Received: by 2002:a05:622a:2c7:b0:50f:bc57:d69 with SMTP id d75a77b69052e-5162f2b77eamr86175381cf.0.1778738731967;
        Wed, 13 May 2026 23:05:31 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d16sm4342243f8f.6.2026.05.13.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:05:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] dmaengine: Move MODULE_DEVICE_TABLE next to the table itself
Date: Thu, 14 May 2026 08:05:26 +0200
Message-ID: <20260514060525.9253-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=sfLQhQwFGpTeogFBIPpVZh0bM1trgBhBsW8I4eM8Xng=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqBWYlqiaiC3doRpw6RU1Ex2452Gw4wZ1J/kx5z
 CfKqPoaORSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagVmJQAKCRDBN2bmhouD
 1+1zD/9g+oasiyg6mKW6uB6ZY3o6jNWFmcKOALFTFxHsyP/DjNZyKXJvZ2gc73g0pvCpurQuXd6
 ru2tpRZbSKDNkTXtxeK30eWLwCigbbHUy7/69yl+0q1bMXOauFbeH5rID8NxrT2cpk5tgFr2R8a
 zfvpXUzm0352sDBaN1idNTMCZ0o0j2yf/f1vQ2VsXmEHxRNSM4f8V4sg1BNAJiYcYehdYHzw3Q5
 UFmN/RBcyv4IeAKxnzt6GbWBJMUDFYFytx0brerr8Jzgjy0+qdn8t+m0NTQCWKBI4887UcLd16T
 y+drYhjbQsm5i13+dk3CdA1M8Po8Wneu3/3oqjgCd9ofXMtQI7TyRChDA8IYnxDnUkRah//BqHS
 s5arn0B4L4tXAW2j/yAgmKoG1Ntqs0j6LDCXzhCwB6Ml3HDuokA+nkELKIOiRPJoVesQN+DZfsc
 In9RyHI5ZsyU+PnGYrJS/H/Sd4PcLWyFzqmUeNlTGAUlpnMoukfvstnlVChCFU7RMUNtWKeX7lh
 +QsOdi5FuZM23uOHuhnv+JarYKapAPM9lyjBlTI521o0ps1UnqDGr/Xsutxe8wm5vR+e2HEL99g
 qsTCvqFIWi1bi9QfIwQAnlkSyJKyXwvpRPi19NUmtsRUubSKzkwue9Yt8FhVnotuVF/vOskUBn2 Wme1uVbzrCoBfZw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZKfnD83d0rQhJbaaQZOuXStoqhqz9V2E
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a05662d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=zd2uoN0lAAAA:8
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=BTeA3XvPAAAA:8 a=QyXUC8HyAAAA:8
 a=UPwjdVLwzqKTMXskr54A:9 a=a_PwQJl-kcHnX1M80qC6:22 a=ST-jHhOKWsTCqRlWije3:22
 a=tafbbOV3vt1XuEhzTjGK:22
X-Proofpoint-GUID: ZKfnD83d0rQhJbaaQZOuXStoqhqz9V2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1OCBTYWx0ZWRfX9c+tz9QNJ6V5
 W/sTt0m4jZTaAx4zDpQHMXNWeVN3xYXUu02s63snJ9T51Q2PpbMDNdgADqD62yTGd1apV89MkWA
 eiaxulygahibcfCoDzpnoSKbeCmPIvxNOQNH8PpuH2eQHpF/1gipB5l69Wo1BkRBwcLtVlLRxc9
 immMDFFFMqrsawZL/BjKJuYCVaIlQbRrgxUudfLg6PPYRVOZQhPz13W2K3BUhimMcDFlbIIWkp7
 hI8MtalB3FCn7mBRWDziVDF6ntA4xxf+0R94yMrhUdSjH+GzqhfpQcaH8YBOnzeOG5mY9QaTLh3
 EWwzi+qdpvwSbt4lbra6r/wKySrluv9xUMprx3EnrWkQXR4TsxfxqUWPiowLEb4w+G5VVph4jAQ
 wZTxbkr2mMv22rPA5Qz8ii/OVhmCtcDukXoicqlmFRt4NUutNgo6zJcmGC3bvQeLcDB+YE198Rt
 hZdIkEoS3AK836UTMrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140058
X-Rspamd-Queue-Id: 9C5F853E316
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10468-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hisilicon.com:email,nxp.com:email,intel.com:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the drivers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Fix typo p->d in commit msg
2. Add tags
---
 drivers/dma/hisi_dma.c | 2 +-
 drivers/dma/pch_dma.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 32a0e95c6a20..28bf818f9aa6 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -1037,6 +1037,7 @@ static const struct pci_device_id hisi_dma_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa122) },
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
 
 static struct pci_driver hisi_dma_pci_driver = {
 	.name		= "hisi_dma",
@@ -1050,4 +1051,3 @@ MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
 MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
 MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index e9fbfd5a3d51..bf805f1024f6 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -970,6 +970,7 @@ static const struct pci_device_id pch_dma_id_table[] = {
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
 	{ 0, },
 };
+MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
 
 static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
 
@@ -987,4 +988,3 @@ MODULE_DESCRIPTION("Intel EG20T PCH / LAPIS Semicon ML7213/ML7223/ML7831 IOH "
 		   "DMA controller driver");
 MODULE_AUTHOR("Yong Wang <yong.y.wang@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
-- 
2.51.0


