Return-Path: <dmaengine+bounces-12454-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zNizLM7CVWo4sgAAu9opvQ
	(envelope-from <dmaengine+bounces-12454-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:02:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B457750FEB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:02:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fDb3qg2f;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=j2C4xIjw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12454-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12454-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B207304E305
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02602E8B67;
	Tue, 14 Jul 2026 05:01:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AF2BEC55
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005285; cv=none; b=iLnzft5lqm3ySKxK0cXq9Er6sBVVnPatJIIfAynH9kqBaX+hTCk1g/jwg/vHZvy2YlK7E0Yvdi0DgvJrrT42GQkH3sKGqH97TiGIHQUdFrnmcSFdInDLO8dq5yIIDj+fUXwrKDHMLxkTvx0j/7iXLgmMHsPa+9ngk6T8bAadibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005285; c=relaxed/simple;
	bh=xxXQ3tAzhzcpJZwiK3EmmM7EKtPJpwX+UibM6B9KZLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tfaNwAye15ZfDLHE0H3Y3Avn4rImFUg/iYdXoRohaw7h7JtaiieHU1sbE73CXdw8/vOr2HM2wTI6QdUS9C+N1NRF9REUB4QTNF/D1JHkCVHrYf0u+p5sjLvyatrvTnCxCm1tm2f0gTqeS0IxBk7RgxAP3JDzIpOL3pJw3H7yRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDb3qg2f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2C4xIjw; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E38QUR3441495
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=70vSSYIPe/KVT6CXE0EZM6
	VHwpcK5x/cEFZ3CpOklkI=; b=fDb3qg2f/TqDV6WpAKpRR3XeqAQqUM8poC3jQL
	5QNU2kuXYoKcNPXKdCFrU34U+NS5yFkYzkGxRE0qewmrAI5Etz9Wxaw1PsXqDS7l
	6WmaNCZ2gcEcjo9HwAC02TATm3c2bc7xTa1jXhFmlL/LcWSOwll+JXfpjPol+Q04
	YaulhszeqrclK9VwV0evZsfhKNECWBEs+W96x+ZfSlGUBTQGtEsQRpiu2dtmFMMW
	B4fw6z7NikNiRXby2qBWmp0x3RaxNgNjOtCfzy9fjY7s9RkvZcx86s2zCvNClt0t
	AIZqURVgJByJga+ZcamF9E7gf1i1PCcelcxUtOA/v62Wt5KQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr48jnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so5898853a12.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005282; x=1784610082; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=70vSSYIPe/KVT6CXE0EZM6VHwpcK5x/cEFZ3CpOklkI=;
        b=j2C4xIjwoVtAgLtI6D3pYhBUOeZislgBXcKdOB8bCozPGTx1kjFC3ERpWCMxoGfZsY
         0FeQ98s1apX0ks+sbxcv4IUqeZiO6OfrQ4km0G+OJG7XWFzydxE4l0kYMVSAIjlY923j
         QQSr2P6gF7ORY8Mr0bGF3a9yVV77AMuqn5RR+MG2oXbZ/WP4c2TcGTzXN0K9FgL6G0Iv
         PcAd65tAIywb/2UrCptpL81DepvtJZsLgukpEXqvrkxAxRUiN1Qqcc+Z6AsWGG6hUKhL
         kQg5eU+nmXTzAnOYlFxhWxukk8gq3UJuKiWAkcQnfbMS19v04qkOub7E+Tn/lLuWz5gy
         Vdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005282; x=1784610082;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70vSSYIPe/KVT6CXE0EZM6VHwpcK5x/cEFZ3CpOklkI=;
        b=jAvbT3Dv62go/LubnOM2QprAhzTxoDJ3KCrsyqfb/bqHSmsCcgoAtRNGkvdKfj9+T2
         h3a39putMXle0skUiXNHt8wY4woBJCeAWpJJz1vI//JNQ4AND6AZCCidRbjODmTM5dle
         oBELGliIku/GfeFzsbvsvCJHQfYwcI10wkoQskW6Mt4IHyhv25hCJR5xCYIsJfDq95bs
         atUdEOuTsVXk1IqV5J4zk+hR6zACCCBjEQ8LN96HNX4ALl2eH7Wgxlk60Wz3KM6Xfkfo
         mmHAA+VsFmgdAfLqetlNcQhebuEochm3gzSuMny1swYEKxtD+S9z8WokXVV1XHsrFgmr
         6xEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrs6Ssls+WDdqJAvRcpOpsgv2g9HtATc2yA0HVjVF7NIqWjXi3Xg8h7rtPN4SE4dCLXBV/+TXaOPOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwP+tKA4RoUWPkHaHQbPV1JQgjvH3Mpcgo/yvHQ/hiWa1DXHT
	SJObVn0GYb6iclRJ/RO6VZVCpREM/B423xPBNPz3bav7fKCRvjBGTIZ5EODASkE8Fi855A7zj3x
	sCwCQNGbvZm51sa/+woax+yqrbztU6swmPP1v1pP7w/C9yHQdeLrcR9sAINbAzro=
X-Gm-Gg: AfdE7clYqhfrwnRMfA4PqZGDMsCv3BsSqtdZyz+8uxTrAj7g8IjgIDZi719l05eeAhH
	EDdPMZP16wkhbK8/NBcS2kVoXxhwLP/Vfb+jQcYkhGBkqKiC5MMksKJd/ayAKFWGgjpKLnAglp0
	kL5GE72vENmVywOUOefVWRf2mnsdq5+9zb+3MnlJ8WLTU09xbfj75Q3Eh7uHzidUlVtYtdeFnTB
	N6hIGNbymZwpG3n74p3ULqyKviageiyHvWlbeD9dfo3YwlfES4LblTP0lqzMmx8c357pnvXT9mN
	7MuvrIAOilrkLxSTF6T/v3gkxf2MSLdkeBnSvgf/0PDCBd3z3vUd6MVtf1KsmjO5j5Zouj07XEm
	kpTPBVwdQMYwiljQDF/tmVT72+Hnz7jl2/+ktJfwEo2e97/Y=
X-Received: by 2002:a05:6a20:4322:b0:3c0:9c19:65c1 with SMTP id adf61e73a8af0-3c110a7743amr11079335637.73.1784005282413;
        Mon, 13 Jul 2026 22:01:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:4322:b0:3c0:9c19:65c1 with SMTP id adf61e73a8af0-3c110a7743amr11079305637.73.1784005282014;
        Mon, 13 Jul 2026 22:01:22 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3c1f77fsm9327406a12.32.2026.07.13.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:01:21 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: [PATCH 0/2] dmaengine: qcom: bam_dma: SCM-assign descriptor FIFOs
 to a remote VMID
Date: Tue, 14 Jul 2026 10:30:21 +0530
Message-Id: <20260714-qcom-bam-dma-vmid-ext-v1-0-cef87c57b7dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXCVWoC/x3MPQqAMAxA4atIZgOt/3gVcahN1Ay12ooI4t0tj
 t/w3gORg3CEPnsg8CVR/Jag8wzsaraFUSgZClU0qtUVHtY7nIxDcgYvJ4R8n9iZcqLS1lYphtT
 ugWe5/+8wvu8HaHaAKWcAAAA=
X-Change-ID: 20260714-qcom-bam-dma-vmid-ext-8a3bd3c5c00e
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005277; l=1298;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=xxXQ3tAzhzcpJZwiK3EmmM7EKtPJpwX+UibM6B9KZLg=;
 b=0SYCckzh+nhKn5OMcxLMUXqfilZkbxew8z2T7I1A2nj9YXJrur+EUV3Uc8Djw5DKBGofyWgSe
 DuHn/VyIdM2DLaAOKKZUtu8q1DLz2AqY0ovnJ0uXvzv0HtgdVnOFtD9
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-GUID: S8jCe4xwd20_aZ1qJoZE7ldvNZEfAqp7
X-Proofpoint-ORIG-GUID: S8jCe4xwd20_aZ1qJoZE7ldvNZEfAqp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfXyY1Urw1TpCEY
 ZiBV2WwuUJ9g9H8vpeKktappTwH0h1WDviDjIEMdAmSzVj1NfTG4Oh0Ekq/qpG7+at3FW/dHpCt
 uOzuMIxUMtblUWbp4jHDxvpsjMEqs88RRci7nCIrw/0jOEwFDg0O+M9aUOE9xtgScdNXLyyIN3F
 vAsd0DuQnpwBbe/i8xuv6gHoKq+kCArkuIa8HyBVX1PGTSeNgTeEPlZDZxMno/+P0wf5Gf2yL5R
 QB25XwLXW/ochL7bwjyCajM4gLswrwI1hzKKiGQsMuDfF/SKune0Cdo26jzMPksXgwGiDfB5Of/
 dUnYvnHICbJlbL3JoNYOCzkin+3WbmaiT4DQCcjawjBmm4H3FVEcTNRe4bysPcnnQogk1gVw/mS
 x8PWYSKPeKzLJFZFua35QBacxcwjJMDzX4k13B+HZvDr/rtOhIxoSV9gts5NGBkeqtibiQgOwsX
 9ebHZs0MvR0qG5DTrQA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a55c2a3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ByYuNnzN2TCMuokQ2IwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX7zXuLXt6ZJVM
 FCU2mC7zNsS6K11zlDrVAzQVxxjZ1KGNs8BalfmVErjdl/Q31K4mCo8RCUGzyeiMJA64Of0XE0Z
 jerPIoLy/Af3EjKXgLTb8xNE7qJrcLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140047
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12454-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:agross@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B457750FEB

On Qualcomm SoCs where the BAM is powered by a remote processor that
enforces XPU (eXternal Protection Unit) access control (e.g. the mDSP
on Shikra, VMID 43 / NAV), the BAM reads the descriptor FIFO as an AXI
master under the remote execution environment. Without an SCM grant
for the remote VMID, the first descriptor enqueue faults with an XPU
violation.

This series adds an optional qcom,vmid DT property to the BAM DMA
controller node. When present, the driver SCM-assigns each channel's
descriptor FIFO to HLOS plus the listed VMID(s) so the remote EE can
access it without faulting.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
Vishnu Santhosh (2):
      dt-bindings: dma: qcom,bam-dma: Add optional qcom,vmid property
      dmaengine: qcom: bam_dma: SCM-assign descriptor FIFOs to a remote VMID

 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |  26 +++
 drivers/dma/qcom/Kconfig                           |   1 +
 drivers/dma/qcom/bam_dma.c                         | 197 +++++++++++++++++++--
 3 files changed, 208 insertions(+), 16 deletions(-)
---
base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
change-id: 20260714-qcom-bam-dma-vmid-ext-8a3bd3c5c00e

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>


