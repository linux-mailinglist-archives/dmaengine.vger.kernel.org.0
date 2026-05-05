Return-Path: <dmaengine+bounces-10218-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C8mMNTG+WmmDwMAu9opvQ
	(envelope-from <dmaengine+bounces-10218-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 12:30:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1D4CB57C
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E92301B515
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA1333ADA8;
	Tue,  5 May 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUQAN0OU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AX9UXBR3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024352C030E
	for <dmaengine@vger.kernel.org>; Tue,  5 May 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976984; cv=none; b=rmd52+0lFNUHvMwQizPPhb8k2+AE2rQZgG2nWt3ugq1k9B/2YoN+r+00kq7NmreGGN6dvb0gChu7jy7OiBEkXm9Kg/sBb5z5vFr1JlQWy+Dk9u6fb9I1D75qqz7xYk2lH7CiTEbo84v7F7CQBmSqs5UbOZLinWEnnKoSoRoK/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976984; c=relaxed/simple;
	bh=jDYlC9f0wdUusA+NXeucVzyJ6JkspVyhhAxUBJYZSkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRD9e8HLo0heevJU6FgARWULF57jjslmafYp/6hzPzFU6sWEhVnZboktID7WZjQ1sCSpkIOqLvzRAERVkqDN0RCoWT0BlaW5KDDS1ZYWDcxMjrMODAvdMIDgX0pvTfx77/4h8kZ8/3qKpz+suQKn5C8idki+hHzJeSjWM641usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JUQAN0OU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AX9UXBR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645813eg1960845
	for <dmaengine@vger.kernel.org>; Tue, 5 May 2026 10:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yPuRlY9DAlcu7X20x1uHD78wQc+2QGJvmMV
	SPX7FQEg=; b=JUQAN0OU96yivn1a59/LpPGoo6DmNYNFroARcpGLPPux3p40056
	RUBaAIUXcaUUOVp0uJcnQQrxdEqsOuj2WbYUtSleWqpIVw+nINS8pYDNZjV0hIBC
	6ziOH2ElvSXSYXrkxaY3FvS4TbqwfQipFmFVxwjrmeYKA8FXieUBZXq9Y+D4xxiw
	Sy+HSGpwcpdllR0cScrG2XdikRvV6rPp/0/tECcZTdxwvHaKs0wmcDBVAzTVkGJj
	fLCImAzlyTi0oWkKDhPPUMB5SFJCtlyneb2f4W7PdftcejGt24x7IK28ISt8Ggym
	d2G/lD8QQ67C9V2XrR44MG8dwtyZF5Bo7YQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5duvt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 05 May 2026 10:29:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d890580e1so85519571cf.3
        for <dmaengine@vger.kernel.org>; Tue, 05 May 2026 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976981; x=1778581781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPuRlY9DAlcu7X20x1uHD78wQc+2QGJvmMVSPX7FQEg=;
        b=AX9UXBR30aswxVCNL+LcJQGKOFheOa5GPiRGxImSKwwLx8Q6M3z5aeD7IxwpeyGAat
         qbNx80E0Uq10Q0yjwQQptWCJ3OQBUNFYZ/MuJe5TFHzQ20NwnABwkbes3N0u0NfYP9f1
         my0q1U1zJB65WjnhQdi4PnavB1ojKEgEp9W90Nskuw66T9KE1li0HrpOWBfqfOsWS/fm
         +nsuhn4YRY6xjRvpG/16MpcAcnh8duNjByrv0OZzz64dLOyqYVQEAbl1XjnW7p6NTns1
         RGvqof+Kwteeo/THMdZF+z86xnkCftCjDY41PSIJ7EeH5uoLZouDrdw7gwin7QSdCABQ
         hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976981; x=1778581781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPuRlY9DAlcu7X20x1uHD78wQc+2QGJvmMVSPX7FQEg=;
        b=THyU1FPi+RvNDmpRAhc8Sdf0BMbTS+wiT5AW9JkOg+85Jvhxv2XwHQ48b94DFfgkkH
         akrMdVoPxhviBLBDPcvuMcTprUCQANCNpbN/HtqSO2ZQWw5pCNIwcMQOSb7UsskDBnUq
         EGSQsaQL7/sRtQw54S856DB8h2fuf0zedURsf1SEi0U9B72VZJqA4eDOhXF50prQYlL9
         GOG6Ne2uXeC+ycHgunHqn3RHnr81shBdkyxg8Q0OZmWCQwLMpDamzKztX/KiQXIRPIoc
         YyENEvz2ShiUSUUlJj5KRSgYLJbg5DOPArgaf90QuHdFRNr+4Q1mdbZCKhsyc6XfUrfK
         LYYA==
X-Forwarded-Encrypted: i=1; AFNElJ8Rqd9qZGATAnAxeHDI9ByTc2j8twuq0UbRyxu91ZTciZv6TIfWsTwP6qlFudfZW3CjbQidMHRjPPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90vHM+dsnaBmDATKvZ/bodAKyiGZJ3HMl/TeO+31cRxGj0GIT
	mBRmLY2GRWUmzdhv/kigN8gX2tTMV0++R4c87VVz4lCAEoSoEx/AJEYTZF3WpRR0FATjCVp9k31
	UbEV5BJKw7uoRQSmoPJiihR+h9oMjbEVkfk8boBE7IapjWdB6ViSXjod+pxYyuFqz07h+UdQ=
X-Gm-Gg: AeBDieuBzQmhyLcVkr6UfSEUK8VdjFOWg6Hzd7ROD9kRSvB9E4EJ5Iy1UFw0eb4mnZe
	+M3199wl84tqhEkl8iZf+enppr2J46LcNf9eqPN95YpXdLLoyWqpQ3sUhe1mlmO3RC8Wx6ley18
	dfleUvjWgcDr7Ejo9Li2qS28Pw4yjPvvDNY4RE0xCIEm6zUhIi6oWPu3KUPejVIU01gNq34JLVb
	wR7il7ARKtUtDjJxNHPgtdrO3n3w/a6ZGz/BQMphJeqM+04mrr/zjdU7Ap5ednVoiOnW+aPiyed
	p+Q77psbdq8x4MhyNQx4w64/0fB2+JsbxGfuSkSxVmZ9UpNJGQNZt+q/SO/PO2I1UZ4aAhntKbF
	a9nWSOhmbaqNZ9mKluil92IW892p4MBknR06GWq4uSHDOsT0=
X-Received: by 2002:a05:622a:4cf:b0:50b:38c1:c6a with SMTP id d75a77b69052e-5104be16878mr195604901cf.19.1777976979616;
        Tue, 05 May 2026 03:29:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4cf:b0:50b:38c1:c6a with SMTP id d75a77b69052e-5104be16878mr195603651cf.19.1777976977807;
        Tue, 05 May 2026 03:29:37 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm343399675e9.5.2026.05.05.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:29:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dmaengine: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:29:33 +0200
Message-ID: <20260505102932.190219-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=jDYlC9f0wdUusA+NXeucVzyJ6JkspVyhhAxUBJYZSkU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+caM/W2tvuu+uTVwng6TH/T2NaJDbNXKW/F5e
 qoNE0DULmGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnGjAAKCRDBN2bmhouD
 13kpD/9fqdXjd4f18vlZKHlQAiU1m7vDxCiv0Uhw2QTQySxsJTmICcSAKhv1Zeifry1fg/hN4PA
 Y3w25zsXanZIJQT65oV3907Dx/7ETP4Ws4nfNSxa9bywYEh/ygn6PGdc0R34PP2E4x4OFvzJB6l
 7H+nxEz31BLr21Cx6cM1CFtj0fzsmDM3Xa3wzm0FmXv5spYHgSmZis2Lthm/ZU4lAYVZFe9PQFl
 Vdwh4S1AV08yjKhLn/ek/DmjDFbrhwM+QRLBlW4Ykaz8DMlW1V8ua5mKnfPDP+l3+zRw0qgUCh0
 CAG5k195At6vKwnTNlFtNkRAV2qgikGW+PmH783EXINSsHiU5Udx5aa/byUdOfSSbw+nROEFr1z
 wZ7b8o+axZnEwqKu68ZXZoMexusXSSeKvbDZEqsVV2drypRsdrhWGTinhO+GnQrDuYt3UmWjHVr
 hibat/w0L5Si/XYXMFEgL9azDZKd2zL437oWBajwok35O5jAOKT0qRuhUlAq54F87niOjy+JyTO
 Xc2AM3PgmNwRjTAsZxe3/lJ327oJ5mAB8y0T5NNlB+ZXTZKgnDYT8LPSmLfVKrprxgRKzXF5bGg
 abTEY4+TT6jPEd2sbatgqe0EzTwdN3EwynvEyk2kBR+jd4I6d9BTIJk3PIHROjGE3wpXXu/iaPt hCPOz3ODufkIehg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfXyrSe4Wc6GSqJ
 Yojl1I33N55VMHF6otcHY01MNPdnA2iYseb+d/uzoZLb2FbkuMLNvSvmUwnt/iDhbDUzlbJCT7P
 haODYjzic/FBnNnk1L2GyvVmFnqqZtHVx+VcjxkhoJurJ2Qw2JIzoayYUFnpSselOHGFyQN2/te
 oZnmatAjUU+8SVnp4XU0BBVRncftkQREJo41BWJEVENs68A4fKcxOsKzU26voCHcJvqv0D4vK1i
 RBtOS/97pY2p/hix1/8NWYkqROm8rUu72jOfjeEtVaDmZ/JvsCn2n6EyUv3CK/8gDkcbPiFD+uT
 zS0e7HFoxfjy1Ua9BFlKD6jVPpMwvY4xmzMwYUKYcCwCIj/1alFNnkIJBO0k0CjwVFFicEBAt1k
 q3HaeBhMfFAJV+j3kTV1vNJQamifVXyUCr4+cbBSVlf7ULOCmFasTErt1jzZaBXiv5l7od+31fA
 P0vjLo306+A4FtbLONg==
X-Proofpoint-GUID: ELdNKb-kleabZbWplsnCIE3N-0sYtYpL
X-Proofpoint-ORIG-GUID: ELdNKb-kleabZbWplsnCIE3N-0sYtYpL
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f9c696 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=BTeA3XvPAAAA:8 a=QyXUC8HyAAAA:8 a=BzP98TPolLMEYMmIy-QA:9
 a=dawVfQjAaf238kedN5IG:22 a=tafbbOV3vt1XuEhzTjGK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050097
X-Rspamd-Queue-Id: 65B1D4CB57C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10218-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,hisilicon.com:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


