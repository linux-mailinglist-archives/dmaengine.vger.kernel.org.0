Return-Path: <dmaengine+bounces-12175-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FhWgHs6rT2rymQIAu9opvQ
	(envelope-from <dmaengine+bounces-12175-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D4732041
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:10:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jKcQlZdL;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12175-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12175-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C77D3160DEE
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0359434417;
	Thu,  9 Jul 2026 13:47:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BD434410;
	Thu,  9 Jul 2026 13:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604829; cv=none; b=izNIa33Thml4JQoXCZOV4hDl7wnpBbKipoyAG2dil12B7xotOIM9kh5Yp6h8biZaI+/2ht/5U6szbXn2M/I0IdcwyWMV141xv/4/U3AnSWhlgDuW6NaWaZRHOstolPkd2gn08l1CEFOxASEGcm40WcqEr/gkTtFIikbjThgZR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604829; c=relaxed/simple;
	bh=u8joiGkPMPA0P4sdNmqnQeT+hhRhmNd2HgmqkdRLUAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsiRQDvzJfjMaCOGL2bN4TwVAndhS/Uju8kbOaAFZgyM0hqsuqyeSQ5XVGRJBH7z7BTv6JyJihSOkOurDLAifMU50zCgxpskIywzdBIs2p2cuP99znUcuDm4BwwzNT4vYQttEgiba0hLEuOGgM6dyv3tMXPSF26sT8bU73Ma2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKcQlZdL; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNEFn1537348;
	Thu, 9 Jul 2026 13:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kfMRPncTK2i3sYm2e60D300oskYzJalm2Yr
	oz9yu244=; b=jKcQlZdLGrYZTtV8LmYDXo++XpfR0+lbMPezcF/V9Wcibt3xvj2
	lNfC2PzUeFdmfRNGdNvRH9j/ioU2d90XP3T7ruLiM+I8jPUzOugMnL/U8Bd+j9HI
	t4SZaUAdEs7HeTDQPKv+xktnDh80PBvCEmYhEjyAV0OzL7NorVoJzPWQItjvS9ay
	9Skl3a/sEmZRjS+x2qimPWMOP4qJGgCud0CWt5VezUG008norXKjG8bkSlhNc+Lg
	cEJS9ASidH23A9mC5lzKrhy4b1PgKRj74rEUIZ9ADAlbF4CPDoz9Zr9wQVQpwQYU
	CpVFaznDCf0SQCtPqN47/hbPYZD68w9xMDQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydu091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:47:00 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 669DkuPd013478;
	Thu, 9 Jul 2026 13:46:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f6u8kn9hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:46:56 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 669DkuOp013430;
	Thu, 9 Jul 2026 13:46:56 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 669DkumY013284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:46:56 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 33C43217C4; Thu,  9 Jul 2026 19:16:55 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Frank.Li@kernel.org, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, quic_jseerapu@quicinc.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniketrandive@oss.qualcomm.com>
Subject: [PATCH v7 0/2] i2c: i2c-qcom-geni: serve transfers during early resume
Date: Thu,  9 Jul 2026 19:16:21 +0530
Message-ID: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX6E2i65M/p91c
 L7pgi+jp5+7vvgfo4JiUAZmxpBb0aLRxHogu4dh8rQDL1i+nPRInBkgFkj5cRp5U9DiEXuSw0ts
 gzRVQRd8WqrkKsUFUP04pAQesmr+Jwk=
X-Proofpoint-ORIG-GUID: 5A4Ql5uW-ER0GnqpHgeYxmLyUCg9lrXw
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4fa654 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=eoqDfTHS1QObJxGXKcsA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5A4Ql5uW-ER0GnqpHgeYxmLyUCg9lrXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNSBTYWx0ZWRfX3Hv77qLvvnaQ
 uif5oydKIHDH+wlTBylaES0pIUyCn9//7lnvBKvTnIMgMs8eJ9oHz5jAufJIVCWRJUFtHZ1qpBX
 wsF8nor4aXFElekruwtv4zC3snkRobDo/ngQhiDg39g6cFkO11fB6jrRoq6P3J0IoinxcTnm+XA
 rqto5QXL0JILBavYd53j+Q7xcUH4xDQaBaFU3ZJ9mimmCgzhBo75ydfPZKsX9wpXtx0ahXehADh
 N00qi2x5p0maxDEGIi0yyrFz3WIHGeLrgNVmTb5km91sIx0T8DblsEgpjIhDSc+YqNn4FLGM2FR
 kSrxOpyuRAeJAESbEmQ0Ucqa5aUKhnCvFAadFn13MQUcq8hYzdRHmgtl6Ek2oDRCXQupUor/aZo
 mMyjleKeaSCmwAnuH5AQZgx13F+aGTzk3LJD17/kzN4sXSrFf8x5nMDEgyRQ5mNzg3WLSH2mHL2
 QD7GCVVqqFHXMKrRvhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-12175-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:quic_jseerapu@quicinc.com,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:aniketrandive@oss.qualcomm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:url,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linaro.org:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 488D4732041

I2C transfers issued during the resume_noirq phase can fail on systems
using GENI I2C controllers with GPI DMA.

Some devices require I2C communication before their resume sequence can
complete. One example is a USB Ethernet device attached through PCIe,
where device configuration must be restored over I2C before PCIe link
initialization can proceed. Since such accesses may occur from
resume_noirq(), the I2C controller and its DMA backend must be capable
of servicing transfers at that stage.

GENI I2C transfers depend on interrupt-driven completion. During system
resume, both the GENI controller interrupt and the GPI DMA interrupt may
remain unavailable until the normal interrupt resume phase, preventing
transfer completion during early resume. Additionally, runtime PM may
still be disabled when the I2C transfer path is entered, causing
pm_runtime_get_sync() to return -EACCES and preventing controller
resources from being enabled.

Address these issues by:
  - Allowing the GPI DMA interrupt to resume early and remain active
    across system suspend/resume transitions.
  - Allowing the GENI I2C interrupt to operate during early resume and
    restoring runtime PM when necessary from resume_noirq().

With these changes, GENI I2C transfers can complete successfully during
the resume_noirq phase, allowing dependent devices to finish their
resume sequence without waiting for the regular interrupt resume stage.

Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Acked-by: Aniket Randive <aniketrandive@oss.qualcomm.com>
----
v6->v7 :
- Separated gpi.c file change into separate patch due to dma engine subsystem.
- Added cover letter as patches increased to two from one.
- Added acked-by tag recieved in V6 patch.
Link to V6: https://lore.kernel.org/all/b7404cdb-7c67-40b0-8124-d4977a8ed3cf@oss.qualcomm.com/

---
v5->v6 :
- Modified commit log to start with problem description as suggested by Bjorn.
- Moved to new implementation of the logic while earlier replied to comments on
  older design and considers latest fix added recently.
- Made change generic to I2C including GPI mode transfer, this was not done earlier.
- Changed email address to oss.qualcomm.com domain.
Link to V5: https://lore.kernel.org/lkml/20241227130236.755794-1-quic_msavaliy@quicinc.com/

---
v4->v5:
- Commit log enhanced considering Bjorn's comments by explaining PCIe usecase.
- Enhanced comment with reason when using pm_runtime_force_resume().
- Corrected IS_ENABLED(CONFIG_PM) condition inside geni_i2c_xfer().
- Improved debug log as per Bjorn's suggestions during suspend, resume.
- Reverted back comment before devm_request_irq().
Link to V4: https://lore.kernel.org/lkml/bd699719-4958-445a-a685-4b5f6a8ad81f@quicinc.com/

---
v3->v4 :
 - Enhanced commit log by explaining client usecase scenario during early resume.
 - Covered 'usage_count' of 'struct dev_pm_info' under CONFIG_PM to compile non PM CONFIG.
Link to V3: https://lore.kernel.org/all/20241119143031.3331753-1-quic_msavaliy@quicinc.com/T/

---
v2 -> v3:
 - Updated exact usecase and scenario in the commit log description.
 - Removed bulleted points from technical description, added details in free flow.
 - Used pm_runtime_force_resume/suspend() instead customized local implementation.
 - Added debug log after pm_runtime_force_suspend().
Link to V2: https://lore.kernel.org/lkml/202410132233.P25W2vKq-lkp@intel.com/T/

---
v1 -> v2:
 - Changed gi2c->se.dev to dev during dev_dbg() calls.
 - Addressed review comments from Andi and Bjorn.
 - Returned 0 instead garbage inside geni_i2c_force_resume().
 - Added comments explaining forced resume transfer when runtime PM
   remains disabled.
Link to V1: https://patches.linaro.org/project/linux-i2c/patch/20240328123743.1713696-1-quic_msavaliy@quicinc.com/

----
Mukesh Kumar Savaliya (2):
  i2c: qcom-geni: Handle runtime PM disabled state during early resume
  dmaengine: qcom-gpi: Keep GPI interrupt active during system resume

 drivers/dma/qcom/gpi.c             |  3 ++-
 drivers/i2c/busses/i2c-qcom-geni.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.43.0


