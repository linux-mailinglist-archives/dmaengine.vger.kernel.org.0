Return-Path: <dmaengine+bounces-9773-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGzjOoW0y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9773-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:48:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC823690FB
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09A4230069B2
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919E3E0C51;
	Tue, 31 Mar 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWxJoc9v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564C3DE43F;
	Tue, 31 Mar 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957694; cv=none; b=Gm5osuvJ6ssQVoQfmkQ7D/2a8yobsvgMIbWoZfO8Sw66nX9NEesd758Ct5gOxQ8+1w7hOfQx3Q8xPdQB1THRJ8iPzAJDwVQ+tSRaxWmLkgiGAeS3A1A/ZwVe4RQB6sLo5aaILTQF29CyLdv5YosJYSs2aCOZs3fA6RfyPw986s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957694; c=relaxed/simple;
	bh=w5pRZF6uea6M5k397IVeLguUISvyf8Mr0N1vsHjPESo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n0VZDUSEiUr4rBIuWJfW4zRhTPSLq2sK9ck6vJ4Du6ybk+5uwM/J4+qjhWF/YC3ATpSqTFw9XJNrs2wdyJLFEgbD7IoEGxuknSa4I/Xg9s9m64fUZNiqOLVSV9d5GoMFrFuEwVq8+LEUtorLmG0gE7JqVdaiNDbs99ui6U5Pr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWxJoc9v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VB7TOI2408168;
	Tue, 31 Mar 2026 11:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AUux2zk7AwAFrU61+jgegr
	GdcC0k+BhMvpTHHgQXjm0=; b=ZWxJoc9vpo9SLL1/zvs3n2G7VAeaBxOxCl+vq9
	OZJEqx5gUTYHjJmjUd6xYQm3tnhDrpuNPiopNU8wszCOdf/E27JNUfj7CJNi7Egc
	Xfpsm/0Y4yWrVB884X92STdU0gsXUwBlUs592k2c00awbltvvWi0DUsmmvNDxdh+
	6a3NG7QILl8WCEHrleCtIyMVRxqGewA6r4E4oGBNB7MsfH61BaVUtUggHnSmFSnE
	gq0CScTLW71DHsmgdMN7fQkQxAS+uW2c8k7U9Ya/REdQVpfWar47idgbWncjjX8g
	ZU9OL+uAMRnZcb2WfnVdaY3GjbELJOhgDqDPetWMBVmIFCJg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hetw7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 62VBm3um010666;
	Tue, 31 Mar 2026 11:48:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk1vegv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:03 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 62VBm3Ak010635;
	Tue, 31 Mar 2026 11:48:03 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62VBm2x3010569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:02 +0000 (GMT)
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id AF9D12579A; Tue, 31 Mar 2026 17:18:01 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v6 0/4] Enable multi-owner I2C support for QCOM GENI controllers
Date: Tue, 31 Mar 2026 17:17:38 +0530
Message-Id: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cbb477 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1yO_DMxMffipIJpN-DIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OG9m2SHIQnLrLpG_pivlIyuOQVBu77dj
X-Proofpoint-ORIG-GUID: OG9m2SHIQnLrLpG_pivlIyuOQVBu77dj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfX3G6ilNfM1n61
 Wk72lRlHOBvciVgqaYD24/528aEVtRnCorrI3WIgyXYBZvQHtd5kaR1K+Rz67XwkyI3njdchs1h
 M5oPU9oK6BJTSUXYpH/9cByoMBOCKtn/7BqhVa+yB4ZECx3tQfnKF4vXkNkOFLYcKSkYyHotPYr
 j4okLq4VaKl+Naf4SAWI1dSzPLFTdz/kDL82HoYYt+dJSzM9LvrGCrFIsRtBaSdy4QQutQNquwI
 GIqZeDlbyroi21iljhc2sdXi4pIDi9InwgvLkeqBmlsgO5NV8MHcqQn50Ue73NdfY9Ql1HQ30tM
 Q2bHMjbPQ663D7+4hRPknD1OUdUlcKmvd+3r2yu4ldhz1wBpgJVDAE6gG9NVbm1jfN2kwo0pWLL
 aiUdchXbWbaPRubA0iWY8g5J/QOz6fkyKrQNUgy3LP57t96kH8XENl1/hyYejiS9bAsmLZb+ITR
 JElAQUnZbBTa/P8UUbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310114
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9773-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.932];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EAC823690FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The QUP-based GENI I2C controller driver currently assumes exclusive
ownership of the controller by a single system processor. This prevents
safe use of a single I2C controller by multiple system processors
(e.g. APPS and a DSP) running the same or different operating systems.

One practical example is an EEPROM connected to an I2C controller that
needs to be accessed independently by firmware running on a DSP and by
Linux running on the application processor, without causing bus-level
interference during transfers.

This series adds support for operating a QUP GENI I2C Serial Engine in a
multi-owner configuration. Each system processor uses its own dedicated
GPI instance (GPII) as the data path between the Serial Engine and the
GSI DMA engine. As a result, controller sharing is supported only when
the I2C controller operates in GPI mode; FIFO/CPU DMA modes are not
supported for this configuration.

To serialize access at the hardware level, the GPI DMA engine is used to
emit lock and unlock Transfer Ring Elements (TREs) around I2C transfers.
The lock is acquired before the first transfer and released after the
last transfer, ensuring uninterrupted access to the controller while a
processor owns it.

In addition, when a controller is shared, the GENI common layer avoids
placing the associated GPIOs into the pinctrl "sleep" state during
runtime suspend. This prevents disruption of transfers that may still
be in progress on another system processor using the same controller
pins.

The multi-owner behavior is enabled via a DeviceTree property,
`qcom,qup-multi-owner`, on the I2C controller node. This property must be
used only when the hardware configuration requires controller sharing
and when GPI mode is enabled.

Patch overview:
  1. Document the `qcom,qup-multi-owner` DeviceTree property for GENI I2C.
  2. Extend the QCOM GPI DMA driver to support lock and unlock TREs with a
     simplified single-field API.
  3. Update the GENI common layer to keep pinctrl active for shared
     controllers during runtime suspend.
  4. Enable multi-owner operation in the GENI I2C driver using the new
     DeviceTree property and GPI lock/unlock support.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
Link to V5 : https://lore.kernel.org/lkml/20241129144357.2008465-2-mukesh.savaliya@oss.qualcomm.com/

Changes in V6:
 - Addressed review feedback from Krzysztof Kozlowski and other reviewers, primarily
   around clarifying the feature semantics and improving the DeviceTree flag naming.
 - Renamed the DeviceTree property from qcom,shared-se to qcom,qup-multi-owner to
   better describe the multi-owner controller use case.
 - Updated the cover letter to clearly describe the multi-owner I2C design, the
   GPI-only limitation, and the role of the new qcom,qup-multi-owner flag.
 - Updated the DeviceTree binding documentation to reflect the new qcom,qup-multi-owner
   property and refined its description for clarity and correctness.
 - [Patch 2/4] Simplify the GPI I2C interface by replacing multiple shared SE related
   state flags with a single internal lock/unlock control managed entirely in the GPI
   driver - Suggested by Vinod Koul.
 - [Patch 3/4] Updated the GENI common layer to avoid selecting the pinctrl “sleep”
   state for multi-owner controllers, preventing disruption of transfers initiated by
   another system processor during runtime suspend.
 - [Patch 4/4] Updated the GENI I2C driver to: 
    - Detect the qcom,qup-multi-owner DeviceTree property.
	- Mark the underlying serial engine as shared.
	- Request GPI lock and unlock TRE sequencing around I2C transfers using the
	  simplified single field API.
 - Clarified commit messages across all patches to avoid ambiguous terminology
   (such as “subsystem”), expand abbreviations, and better explain functional
   requirements rather than optimizations.
 - Updated copyright headers across all files wherever applicable.
 - Renamed variable shared_geni_se to multi_owner to match the DT property naming.
 - Changed dev_err(print_log) during probe() to dev_err_probe().
---

Mukesh Kumar Savaliya (4):
  dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller
    support
  dmaengine: qcom: gpi: Add lock/unlock TREs for multi-owner I2C
    transfers
  soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers
  i2c: qcom-geni: Support multi-owner controllers in GPI mode

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |  7 +++
 drivers/dma/qcom/gpi.c                        | 44 ++++++++++++++++++-
 drivers/i2c/busses/i2c-qcom-geni.c            | 27 +++++++++++-
 drivers/soc/qcom/qcom-geni-se.c               | 15 +++++--
 include/linux/dma/qcom-gpi-dma.h              | 18 ++++++++
 include/linux/soc/qcom/geni-se.h              |  2 +
 6 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.25.1


