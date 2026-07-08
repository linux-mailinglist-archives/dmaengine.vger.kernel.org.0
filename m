Return-Path: <dmaengine+bounces-12093-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5NwnEOLbTWr0/AEAu9opvQ
	(envelope-from <dmaengine+bounces-12093-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:10:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F38721B6D
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IXySWFd3;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12093-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12093-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AFB03007C99
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412433AC0E9;
	Wed,  8 Jul 2026 05:10:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1431F03DE;
	Wed,  8 Jul 2026 05:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487453; cv=none; b=Rs4g1uSRMD1RKbVkbM8zmy0uXKLJbyLUlayOPzQPM6IcIuDJ/68acUKZSpxp5OhXrF0y8iWVSwClal3g9PO4nWbIR6F+6hgvpvj48jLspqKiziq9F40y5MFrvAGmXxrMh4MiKk6UgdsZby996kEfLyAaDuQ2LwdmmZhpwhMLPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487453; c=relaxed/simple;
	bh=tlPlsJhFLju8OW1UZl7eqN+3lROyCY/hagIXnAHvyV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uKSnrDJV04K2fkp3AsjRxcP3Tvu9kVzy1s0YJ5DH13EqWJNjOtCvIn92wCkjsOWKfJLl+9sAH5ND6lQiL5OYkrVZDyG17/0SwDe6CN1j4kuoFuJfvCWw8iy+eIrL3N7IRi/EkH0m9DadYFqTD/RaRNIZbNWSMBIUj8y8Rov4hSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXySWFd3; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842lE81625566;
	Wed, 8 Jul 2026 05:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wUbLVWmnsZJsYRwC8SrzML
	ZCezHhK1xsSULOh1Fyo+0=; b=IXySWFd3kslgClMfcxgV4OEAkg3usaCRcGP+6W
	RjlsRIPNts6/48jIwAnaD8/CW3M35/HcxuPjyqtAh1j0QiFD/Q65HWa9+5R/ZkZ6
	CNjW4uOwZrc/5WVkYL+H/rBm0L2roHN7TTabMX9M7EOxZbIdygyzV/07Mh08FEFn
	eFDU7BhVGKoiP/Rn3K/mH3QHforwppXPR1KWZOU+tWPF4ApjBGQukM/uyR9z0ay1
	MyTY7V3nDwsl+KQFlFC4tHzzA66rB2PQGaTWJwSGC1WpkEfJqPOgl5NmL0v0hwq+
	gUxIqCoj1IH3AeW3awPFyl02wcP0EEgjCYQlWXDEJrovfoxw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2qqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:44 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685AdMx015921;
	Wed, 8 Jul 2026 05:10:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8kcrwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:39 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6685AdDE015914;
	Wed, 8 Jul 2026 05:10:39 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6685Adcv015912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:39 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 45F652181C; Wed,  8 Jul 2026 10:40:38 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v8 0/4] Enable multi-owner I2C support for QCOM GENI controllers
Date: Wed,  8 Jul 2026 10:40:06 +0530
Message-ID: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX+qTJsUanE1TG
 KdoPReZBnBtqQvzvPnU6o6s8Q1MUcocz9UotclKl+nQsOrhspuRO66f2vljEk29Na8ovNN4eKzv
 CbRfu+qa5KeR9Q9U2cFDFQGLHa7SkzaVDZdJejzujjum6HPK1gVkl72WcbkngRYQFnZdkfdQylQ
 iF6opw9+vODmOHGrwf4b0oCPfUj0lcTUB7BfWuJnCg1kyrAodnJLFpSV7e6k9zvcr+RDGwh7Urz
 iTKzlt3CrjqVK856HW7fmsMgl8SLQZz71TWHVCUbIoCrZsYpfowEWYSQ3gGi7VnVY3kkYtjdEg9
 vcU5ect4edBBhdb6TkSuxJ1yHjUlhxJXkOq8jKAWhttmnEMzxyDVXABcVGNlqjK6SGtldhnuLim
 7fsyMpzrw1Vouuj84IjWioiOE7eXaajhHHShvlmLeBQUTYvx42aCQ/o8+CL8L6Q6FwPflxDwsYB
 4JNWLfdV0vuvABUjt6w==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4ddbd4 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=he5lF8nT1moT07yA0wYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gMz8v5TLtSaaepUoUTVVc8H6mQGYlfG2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX6R+/HxF/7qgk
 e5pK3nfr1RQ6jGKK+VEn3CR5q4VgEfTjpYm6tfopOCoE5rcUx9O7VlP/InZNE93QHsDaD1NIfBS
 yLqUhaiRcFG3ZuEm6blKaY9XbMnASqM=
X-Proofpoint-GUID: gMz8v5TLtSaaepUoUTVVc8H6mQGYlfG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12093-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93F38721B6D

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
Link to V7 : https://lore.kernel.org/all/20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com/
Changes in V8:
- Documented that multi-owner controllers must not assume exclusive ownership of GPIOs and
  therefore sleep pinctrl state must not be selected.
- Documented that each owner is responsible for maintaining required resource votes for
  shared-controller operation.
- Clarified commit message to state that lock/unlock sequencing applies only to
  GPI DMA mode transfers, as FIFO mode does not use the GPI engine.
- Fixed GPI lock/unlock handling for single-message transfer, ensure both ACQUIRE
  and RELEASE are issued when num == 1.
- Simplified DT property assignment by directly assigning of_property_read_bool()
  result to se.multi_owner.
- Improved error message to clearly indicate that multi-owner configuration requires
  GPI DMA mode.
- Updated code comments to follow kernel style guidelines and improved wording for clarity.
- Rebased patch on tip.
- Added ACked by tag for Patch 1 and reveiwed by tag for Patch 3.
 
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

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      | 16 +++++++
 drivers/dma/qcom/gpi.c                        | 44 ++++++++++++++++++-
 drivers/i2c/busses/i2c-qcom-geni.c            | 24 +++++++++-
 drivers/soc/qcom/qcom-geni-se.c               | 14 ++++--
 include/linux/dma/qcom-gpi-dma.h              | 20 ++++++++-
 include/linux/soc/qcom/geni-se.h              |  2 +
 6 files changed, 114 insertions(+), 6 deletions(-)

-- 
2.43.0


