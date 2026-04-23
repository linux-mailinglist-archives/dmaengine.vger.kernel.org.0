Return-Path: <dmaengine+bounces-10090-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJJoDacz6mkCwwIAu9opvQ
	(envelope-from <dmaengine+bounces-10090-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 16:58:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA3453FB6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5763E3083DF9
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44090330D23;
	Thu, 23 Apr 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/K3kKb9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0061624D5;
	Thu, 23 Apr 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956245; cv=none; b=orlAvKqHQvj8Kt/ZPCqEELV6cL470eo/YuS/+u8hZ1a7RucZKrjwpJUfhscZr1mqYhEWqk+PBrrGG682pvh9KdeeJ7W1sbJiZGLnK+lCwlIMz5H2DvnvLgE/wNf32hxkjKVTAVLmWhc0p4SUNN9IM+tlpWk75Tv4Xw9OQcM4s/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956245; c=relaxed/simple;
	bh=YO7uimmogf94fBti+r1q22cdT/6gxIiP2BRAF/hiPM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i21pRSXy6PX8RDaZ5Gfdu3h9lBOXZ/JJYxCUaEbYTJakVXt5Vy4sKe6cHqjxN4r6DMhR8qHnIAW8Q+WgIm0KvUq0xNodCIdudxYUFXsTprFRmCu162FZSVFOgMl2Ae3CU0oYp8CP8YhoPxHZZmng1wUKyswVxbR1+RuLUzdzAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/K3kKb9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8u45j3768991;
	Thu, 23 Apr 2026 14:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6lH8naoBlkskpbP8iT6CJp
	xOKSSew15SkbohzS8SlLY=; b=J/K3kKb91JQhOEFy4E++aRSAlMTOkmgb0K6Td7
	RmM19Ee1Xzhdw7QcKcQe9/AP/DmGmQn3i9ZYW5O12qAlKXtEi9WWsrjoJKVDIDVc
	uRW+stXu5EV5hD1eDSs8hQGzmayIfCnuEn4894pc076Wyi6o3tnN3OSFYB5tOfOZ
	TxE5Wu+3gln7uf0H+bOKd1A4lP5rRfqh5PI2GUCEfhI0fWFp9RP5ZXLUnQXh1BRT
	MoMXx6Jk1BeAaMHl/NaSifFNCcupkqRxA73gjh48uNYWmpJT6CxdId38o1fkk2xe
	8x5D64JlcJIOGkILmB66zW4BCgHrih4JdMSn840smNWqIBbw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq4drc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEvFa2010837;
	Thu, 23 Apr 2026 14:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4dm31k249u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:15 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63NEvFdg010830;
	Thu, 23 Apr 2026 14:57:15 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 63NEvFhX010826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:15 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 392CA21C47; Thu, 23 Apr 2026 20:27:13 +0530 (+0530)
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
Subject: [PATCH v7 0/4] Enable multi-owner I2C support for QCOM GENI controllers
Date: Thu, 23 Apr 2026 20:25:47 +0530
Message-ID: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OSBTYWx0ZWRfXy5lmkXxLWlLd
 BRhp8nrYGAzjIxsThiJwjJdrO+U86EC7j7H+gSmj74b89P39Dy5ian0gZDqhls0Gg5lPoGfHIsV
 vMffI2dj2KkdGJXQMmbMcnNgGfzG8QiPjsrWbvmrfTVcQK+c7JDhnPOKjLrUj3JgV6/CuWasObP
 Tccq+f9vz4qECJvVud1RfoAqieDq9OIC1BKsg/vOuIBUYpaGfVEfDe7phJOyFgXvrBEnI8NXydH
 fm+OFBOsGVwsu3GAyXVIFDvLXhqxpGjWGlnB2KV7MegFmqkeJpvKEbUGJje5cofrC4ZrNR2/fdB
 rrHdULuJgPBpqfsxn6cP8aiv60Hf9oOpvvaJScL7RcoojcvTijCY+8jy9gk0uR6oNlnmfCmWs6g
 Fn3SjXbR8jE/v6mokoUSkkSj02r2IdCTBx7ah5aMOQefjTSfkG7TOi52tlxZ8Rd5fa7yygK7yRV
 0Qo9v6FoIX6OOCpXooA==
X-Proofpoint-ORIG-GUID: lPNHdrv6Cc5T2I-nN7ReFKYid907dH4X
X-Proofpoint-GUID: lPNHdrv6Cc5T2I-nN7ReFKYid907dH4X
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69ea334f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hcHQekJc3wpFfe21-KYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230149
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10090-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 15FA3453FB6
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
Link to V6 : https://lore.kernel.org/all/20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com/
Changes in V7:
 - Added Acked-by for dt-biding patch 1 given by Rob.
 - Minor description change for multi_owner variable in patch 3 and added RB tag from Konrad.
 - Removed description of multi_owner DT property from code as it's part of kernel doc.
 - Returned with dev_err_probe() in geni_i2c_probe() - Konrad's suggestion.


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
 

Link to V4 : https://lore.kernel.org/lkml/20241113161413.3821858-1-quic_msavaliy@quicinc.com/
Changes in V5:
 - Corrected name as qcom,shared-se instead of qcom,is-shared.
 - Added description for the SE acronyms into yaml file and commit log.
 - Renamed TRE_I2C_UNLOCK to TRE_UNLOCK being generic.
 - Log an error and return if non GPI mode goes into shared usecase.


Link to V3: https://lore.kernel.org/lkml/20240927063108.2773304-4-quic_msavaliy@quicinc.com/T/
Changes in V4:
 - Fixed Typo to dt-bindings in subject line of PATCH 1.
 - Replaced SS (subsystem) as multiprocessor as per Bryan's suggestions.
 - Replied to Krzysztof's comments and replaced SS with Multiprocessor system.
 - Removed Abbreviations and also bullet point list from  PATCH 1.
 - Changed feature flag name from qcom,shared-se to qcom,is-shared.
 - Removed bullet points from example of usecase and explained in paragraph.
 - Changed title suffix to dmaengine from dma for Patch 2.
 - Rename TRE_I2C_LOCK to TRE_LOCK in PATCH 2.
 - Enhanced comments about not modifying the pin states on shared SE for PATCH 3.
 - Enhanced shared_geni_se struct member explanation as per Bjorn's comment in PATCH 3.
 - Moved GPIO unconfiguration description from patch 4 to patch 3 as pointed by Bjorn.
 - Removed debug log which was unrelated to this feature change.
 - Added usecase exmaple of shared SE in commit log.


Link to V2: https://lore.kernel.org/lkml/a88a16ff-3537-4396-b2ea-4ba02b4850e9@quicinc.com/T/
Changes in V3:
 - Added missing maintainers which i forgot to add.
 - Add cover letter with description of SS and EE for dt-bindings patch.
 - Added acronyms expansion to commit log.
 - [PATCH v2 3/4] : Removed exported symbol geni_se_clks_off(). 
   Instead added changes to bypass pinctrl sleep configuration from
   geni_se_resources_off() function.
 - Changed title name of [PATCH v2 3/4] to reflect the suggested changes.
 - [PATCH v2 4/4] kept geni_i2c_runtime_suspend() as is and removed 
   explicit call to geni_se_clks_off().
 - Removed is_shared variable from i2c driver and instead used common 
   shared_geni_se variable from qcom-geni-se.h so that other protocols
   can also extend for similar feature.
 - I2C driver log changed from dev_err() to dev_dbg() for timeout.
 - set gpi_mode = true if shared_geni_se is set for this usecase. Enhanced
   comments around code and commit log.


Link to V1: https://lore.kernel.org/lkml/cb7613d0-586e-4089-a1b6-2405f4dc4883@quicinc.com/T/
Changes in V2:
 - Enhanced commit log grammatically for PATCH v1 3/4 as suggested by Bryan.
 - Updated Cover letter along with acronyms expansion.
 - Added maintainers list from other subsystems for review, which was missing.
   Thanks to Krzysztof for pointing out.
 - Added cover letter with an example of Serial Engine sharing.
 - Addressed review comments for all the patches.
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
 drivers/i2c/busses/i2c-qcom-geni.c            | 22 +++++++++-
 drivers/soc/qcom/qcom-geni-se.c               | 15 +++++--
 include/linux/dma/qcom-gpi-dma.h              | 18 ++++++++
 include/linux/soc/qcom/geni-se.h              |  2 +
 6 files changed, 102 insertions(+), 6 deletions(-)

-- 
2.43.0


