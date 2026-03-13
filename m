Return-Path: <dmaengine+bounces-9421-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBfeKryzs2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9421-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:50:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6E27E559
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F7A301A3A2
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDB3537F0;
	Fri, 13 Mar 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hJLgPv0Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MjwttMt7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC02989B5
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384577; cv=none; b=i00D3u2XKq6k9Cvm8HUGpqalXPDTbXi5F4N70nQd9cPC6fHq+LuIPTmdGiBHkO90e1h7Z/B9amXjvJtV0UmbcpX8N054S+N741EUZXwCl+wyWQLxFSf7iwvMduaKRQulc01v+vqUa9ehWOxRRURmtsr6VVpX3yyvU3jrRMMf/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384577; c=relaxed/simple;
	bh=pvlk2gOPkIN+ITxicWXFZ618jc3EqUbu9jfuBJT+Pj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MaadHMBAHVGcB6Pde24qD9r/xgBv3WxRwpnlR3rlHPoS4r4gfs9Pjjo3s/WYCjkhCoQapqgeFc0W/IEz4LK7wImuUN6oaLXezROKSidJE2rYMqEOQI4uyz2c29osXOehL+ANd6Zi+AEXbcMe4wZ/b6VFNnaOklffaftemyCwWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hJLgPv0Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MjwttMt7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5thl21014950
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5AVmFAe9Ik/fE0LX/BsA8E
	1wHztxhMYSWxglI3gqndc=; b=hJLgPv0Z4qDUBFVMEQHi0DDoGS8X4keR73BE3t
	RKLGdEhNe7yWwXWndunp/MZkJR+6CSGY4Ke9tdGCng2D68Bpd+vEhsUfqxG2HwO7
	ZiJlG8zfhLXxIcXG0KTwyNnjL8tF/0S0zdDsl7UKHOB5ZQjJyHvKXLZ2tpbfLglV
	K8jiGYC0yrdyO0Eu383hfcRUAqPFoDCAHgqcbs8VwrRaFAfN+CoTk/CBnYDnapUC
	ZXjC6iQnXBdzEhzfYSWasyBpiY2RgaAREBvHW3z9nLk5u70QOCUtywwUci/rU6cr
	yaveQe29DY55nFQW5Ei5O3g2ASPT61JY3EmJVnHtM6lWJ9bQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvdm7k3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1599087a91.0
        for <dmaengine@vger.kernel.org>; Thu, 12 Mar 2026 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384573; x=1773989373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AVmFAe9Ik/fE0LX/BsA8E1wHztxhMYSWxglI3gqndc=;
        b=MjwttMt7y0Tm2zBnv5PpTF80+1Yc+VQbJx0EW+i6vQeXrzPDwg1UoADP3cSUBp6Nzr
         pqrXpG5M1vG3T8NT2/JWbO2URs01uSGmeIaQPp3YexsU0BdvrGIhU4agGTmpJe+CFcxG
         7oRSeofL3sDoqtDKFZiyOPs9ehluvD/GznghRoVx4dJnnEhAy3ESYDIJLixSBkx3S15M
         Bl5MN8rEFZHwy8XADvNUzuWjFhP7FCS37vxwjeRXQhWN2UC+oHBhKT/gIj9uQBNHMbSo
         +IoH2xzko/nzjriGQilgRWs8F/mUZrxwjuYxB0drCKVtwrNm5fxlO/gwplyYLUsetgSc
         SR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384573; x=1773989373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AVmFAe9Ik/fE0LX/BsA8E1wHztxhMYSWxglI3gqndc=;
        b=eBI7fzl67Dalvp6PkZxVDHz7rWHwZt+aJwv8oa3/K0dwJt1Cu7hYDFdHnJn1AGyvDt
         /S59eIodoL6K93Qa7XXxGXZ6MC9zycV5Vdqs7jMkP5lJDSuF+TtEVLxVk036G391d+X5
         ErNePX0j8WNxLbCEqVgqIJQri1FiKxpunLPnS/3EIWuL+Iprmw1g7f8dQ47gASTrxaS+
         lcg68rzrLQqJIBnKhQaY0eH7KWRCjTaRCvkyKemvkoOFJix7EtBT9xujnj+4iCUKLDvU
         KHyKaQ14LHdRr2MoPRivlyViw4koouF75005mjCbMYgh6oUz7z7S7gN6EmnX4kEtKAim
         aSxA==
X-Gm-Message-State: AOJu0Yz+DeZyuDBShP8dQtYSAsA4vs9MnTYn515CDamm4KovTKmXY2BP
	LDzpjqONMAmEL837jx5NLIXq2bZrsyPAMigkXOpsU0DU8/t4bEqN5lK26tXRUhQOWIXnwG3JwyQ
	5YOgltvKW7JNyradG4Lb/sRTKrQB2oL5z0pUPvwv7kwOp6Qx2TtJsMVFezzL2W9s=
X-Gm-Gg: ATEYQzwp/EaEGgGF/r5iEctPG69sj3Awyw3kD41t+gQc2pXOnyOMGUHY4nkOaBC/LoO
	BdLoux8vWYCQRLmRliiZTayr4+gUUUUVQuiILjmLZJrdMolJsEkeomhNfuAaIcB+EkVzuvo71l4
	/HmIiDDYivJ6g0Xv5B6bzmin44oFjUPMlYZkWwUtzIdGzZAUYAREE3lYkNIqvajSpYHcQcNlNLI
	PhQsJQY18QGr4pPA7R95j38zq/52pi7zMIwaXqnkUCSrtODCvqkyEv1/Q1Cajn/ejZmNMiUcKLH
	8SgDdnA0MUPZecn0YOCHU/hsz/qemg2E5EkUT3uZToNVAEaoMqlVy+55EdYK/nKad60mBL/Q9Np
	WUTPaxREh+G5Fahj2iqjJlcU60y2cg9e9LFvip6C+DsOX57Y=
X-Received: by 2002:a05:6a21:6197:b0:398:afdf:3463 with SMTP id adf61e73a8af0-398ece212b3mr1705940637.70.1773384573484;
        Thu, 12 Mar 2026 23:49:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:6197:b0:398:afdf:3463 with SMTP id adf61e73a8af0-398ece212b3mr1705918637.70.1773384572883;
        Thu, 12 Mar 2026 23:49:32 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97b41dsm936160a12.5.2026.03.12.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:49:32 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Subject: [PATCH 0/3] dmaengine: Add batched scatter-gather DMA support
Date: Fri, 13 Mar 2026 12:19:24 +0530
Message-Id: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHSzs2kC/1WNwQ6CMBBEf4Xs2ZJuUTCe/A9DCJYFNqFUu0A0h
 H+34snLJG+SebOCUGASuCQrBFpY2I8R8JCA7euxI8VNZDDa5Br1WTWurtw8TFxJp6zBIj/prMi
 sgTh5BGr5tetuZeSeZfLhvdsX/LY/kdHZv2hBpRUezT2eEBXYXr1I+pzrwXrn0hhQbtv2AQN8W
 02vAAAA
X-Change-ID: 20260108-dma_multi_sg-c217650373c2
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773384567; l=2678;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=pvlk2gOPkIN+ITxicWXFZ618jc3EqUbu9jfuBJT+Pj8=;
 b=CJsyKHGdctf6eMe9FYY1OpAZhEpTLB18Re4kWKHiZ0+TKe0AV4X/h4B2qhl75oyvumt11XvKa
 T/JaOl/TpY9ArzGxVUQ0/u9VR0ZLcx4FAaInJyDJiUPuxoHqhv3XDfC
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MyBTYWx0ZWRfX4CCxC5SenWZQ
 mYmeD0BzoRFth4Pl2akCa2Dpws2VVAtil8MOdlJHgwnreZEH28rgB6FfxbbHJNp5/ywxnx0AJST
 YrqTn7LHJfSbSmn9mri1pECJIcDiuWRbgwDclfMmqcDJ6z4tGoBTPAejYu9iwnDIjZRc/iFdWpY
 2uENXvjwaNhp7cqRbpooaYOsWky/PdFYzlZc3xLMH1i5qMFQvBdRDZbyvlCr/C/2TuFXJtQbJ7X
 GWrOv1j8shK3gpOH2byz6gwwc8XrRo5Rp5jWRxln7OG2kJLF4TceV3jovUFpO0/QQsOKbPoJhOH
 TT5wZBPNhAUfgNui693F1/V2VoqeVKODWEZ1kSQp0T4lS3XGIO8KBttgczrPSKQboccmn/X3aaC
 WVQPNenPNHmzsLxbqN8LWC4ebmu3nOMgik7dja3Rdz5QqhX3KZ3Jry2+rfQmTkL2nBQiTUxZaxw
 7ZhUDBNDveb7sjXKhig==
X-Proofpoint-GUID: gFgJZDLWboVkishrKEllOefRUh5dQFiA
X-Proofpoint-ORIG-GUID: gFgJZDLWboVkishrKEllOefRUh5dQFiA
X-Authority-Analysis: v=2.4 cv=XsT3+FF9 c=1 sm=1 tr=0 ts=69b3b37e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=f6ynY6_RdjVN_4bGfK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130053
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9421-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.kumar@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4EA6E27E559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Synopsys DesignWare eDMA IP supports a linked-list (LL) mode where
each LL item carries independent source and destination addresses. This
allows multiple independent memory transfers to be described in a single
linked list and submitted to the hardware as one DMA transaction, without
any CPU intervention between items. The IP processes LL items strictly
in order, guaranteeing that scatter-gather entries are never reordered.

This series leverages that hardware capability to introduce a new
dmaengine API — dmaengine_prep_batch_sg_dma() — for batching multiple
independent buffers into a single DMA transaction. Each scatter-gather
entry specifies both its own source (dma_address) and destination
(dma_dst_address), enabling the eDMA hardware to process them as a
single linked-list transaction.

The primary use case is MHI endpoint ring caching. When an MHI ring
wraps around, data spans two non-contiguous memory regions (tail and
head portions). Previously this required two separate DMA transactions
with two interrupts. With this series, both regions are submitted as a
single batched transaction, reducing submission overhead and interrupt
count.

The series includes:
1. Core DMA engine API and DW eDMA driver implementation
2. PCI EPF MHI driver support for batched transfers
3. MHI endpoint ring caching optimization using batched reads

Performance Benefits:
--------------------
- Reduced DMA submission overhead for multiple transfers
- Better hardware utilization through batched operations
- Lower latency for ring wraparound scenarios

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
Sumit Kumar (3):
      dmaengine: Add multi-buffer support in single DMA transfer
      PCI: epf-mhi: Add batched DMA read support
      bus: mhi: ep: Use batched read for ring caching

 drivers/bus/mhi/ep/ring.c                    |  43 +++++-----
 drivers/dma/dw-edma/Kconfig                  |   1 +
 drivers/dma/dw-edma/dw-edma-core.c           |  40 ++++++++-
 drivers/dma/dw-edma/dw-edma-core.h           |   3 +-
 drivers/pci/endpoint/functions/Kconfig       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 120 +++++++++++++++++++++++++++
 include/linux/dmaengine.h                    |  29 ++++++-
 include/linux/mhi_ep.h                       |   3 +
 include/linux/scatterlist.h                  |   7 ++
 kernel/dma/Kconfig                           |   3 +
 10 files changed, 224 insertions(+), 26 deletions(-)
---
base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
change-id: 20260108-dma_multi_sg-c217650373c2

Best regards,
-- 
Sumit Kumar <sumit.kumar@oss.qualcomm.com>


