Return-Path: <dmaengine+bounces-11509-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3GLaJDGXL2rSCwUAu9opvQ
	(envelope-from <dmaengine+bounces-11509-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:09:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09664683A92
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pPk1l+WS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=L1xbMGw4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11509-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11509-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD8B6300CC36
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BB3AF664;
	Mon, 15 Jun 2026 06:09:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71D3859F5
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 06:09:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503760; cv=none; b=M13JU3oVF2sTiSWX3gRNxYfWabuzxeGS21MA5FbEnwSsVSEv7Qc+RkoeipnUBsKt2zAR84snD1rsejX93eXjb7Z/054D/UZmrl9KZmiyak4sv0Y+v1TX6z0VdS9d6DwKBsqG59VhjkildKM/PmhVdRoUYeJqTWgvi2Sqxs9NYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503760; c=relaxed/simple;
	bh=PKgXeShLxwaVF7Anm07f409jvOs7I7Dr6y/VL6J/1Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iICvkP5wuAg+rshGFp9zaXpYK/frDZ9TZo10e2xPTpuuQb9fnMltDjGQntLT8F1oM9zJRVgiguARMU63Fa3g7I/Vr6WbEyqAJ/swmUKpAW/E+EWC2EvuOZ6VtKW6IUY3K9T7tPn/cIjcgpaM9KHeCPf5R2q3F6A0umqxnRIElAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPk1l+WS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1xbMGw4; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1hvZ62725830
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 06:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tS
	Y4BCig+o=; b=pPk1l+WSLZ+ykDB+yhIWI6qvYtp1eYTclvYXJS7ZQV6bim4LQAH
	7gaWpMOcagPltj6XRGey+dezLl4hObcOAODz2+Dol7qGKzif+m9SAs9Y/dKzCigU
	96qcun0jKsXnPM5fYnlYaXffErRiUVaHJQd7KcDz1K6eJhRPErqIveB+G9cxXhs0
	cnXCqoFCvpEADWsxp30N4DKuMwu5eKzI3KCIfN05aDgbG1yF+Q7zC7s+ndROJ/8L
	WqX8alAJFwV8EQV9m9P0pOL738fy/eFOxYRsujTbhSVP89FbZi1XVWvrSAndgZKy
	bbLOvLJ/+siCNNGvP1qFC5ujeRM71Bd5ypQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgnm3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 06:09:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so2261091a91.1
        for <dmaengine@vger.kernel.org>; Sun, 14 Jun 2026 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781503757; x=1782108557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tSY4BCig+o=;
        b=L1xbMGw4nqSuNxjx1Aal/IZSgkhGWA53kvI39qj+P58s3Olq1e3qJdQgkkPmsDAc+c
         ZtWmzi6GhLvgRmUDDMx6qi1CPEgcuuYMDnzPBHaqJcInYNz7tuW9t0p2Uf1187Fu748D
         pZd9lsIYc2yP+4saum6b3EHlVaHy8AfrINdfQkpoSiAxFamnO3GgDogGKCFRu335xiPx
         QF3BlEeh/BLXfauSS280flcjcA+IM8JE3golntCMnR9XJMO5cjnobbZ6PK8hfPPg9gub
         oKO2Ivot0UpUj5WB7jlSTcXGfVS8ET45IXtv0h22f2hMkNyrYz4/0jFQCtZdZw4skzpN
         29kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781503757; x=1782108557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tSY4BCig+o=;
        b=cIIrdpSYeSetSz4DoNU7HpoXgGe//R5QsI9RLtp1ihc5NM7Yr9hmnF09vn53SrM7ck
         9zuXz6eKVqChqaGhi0zcASvxIsFR8NcqrQ3tsNnJoZqgI9LCx+GVw+iSYGKg+8znhi9W
         7dnASVfCZkYxURCdYJ147UnMrPnFmLuQU7apYwOPaCUJaP4l8fOV5sOG8/irnnu/mpRS
         bHc1To+OAe3Z11nKIjRd9E/75IaOvq8V5Gi+Ga2uusVXSgJLRspPsyhHS/abJ8UUqWBN
         GxcD+K5AoM0fr8p/kS6IA6UBE/tq5sYh1VxN30jrkolY21RkWqSgXCxdqZjWl944gf1I
         1jZw==
X-Forwarded-Encrypted: i=1; AFNElJ8eBkP3T9PbPZc1TbXxV/0VTlU/WkxhA5kro4oo9uuFURRM2SST85CZxarCalqEgw9DvddGUqOf9Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpDBMSIxq2uEct43ir7lFBs+YiXeoDV6kn80YzSkd32Ib4TYJ
	CywvlXr/onxYxI5IgmFfT1tvHMmM30thX2Ct/4IOmsv4zTZ+8o9UNhBWDjOuwKmKX7MH27w+QBS
	kZoFOJZxLQjqQxAJ07hQQfOlRWN6KDxOQe+vWhAd9l5FPmpGKL9OhpjgT0KLppWQ=
X-Gm-Gg: Acq92OGiQTkGK7qF6SE+JeiMo7BPvuhTQd+T9J6dM62QWg30u0UVrNJm/+BD/YOhNbk
	w+wrfnuYAhTMCILOYC8wbedquBDMTIdAZT4PH3Oa24bwi3uRD39nD1g/a4LPWbQiiclFbKUiZie
	tdmz2xGOXa2HXVy8FkbvL5LbvnVa5CHFpKaOp+SokaGvExsk01b675CLUo1QW8mvr1BaxuilTZh
	jt7jnmWGo+TmLN06Y2aTSVH3WaeWlb/ThUebr+xiYOdlwfm5DnQUfMe3Do7PjSPU3gOvk4MwNPY
	GHb5zXX8165gEVxtKKsWAsNl+LvAxDj3benWsiSvsJpYmqkNghqJYvJKQb2R8SGEWtkhhqSqLW0
	04K+W8UJlOARFUwol3t/7+i9rtYIgxgwVRYOxIenVY7rbN5bQa6B5Ie5CtocGERpiweZbDoQZm8
	JutOq9B1gKjhuaLVRBIW0VMi2TnUZ8sq1dLfopIYMIGNkSfSib08g=
X-Received: by 2002:a17:90b:4c4b:b0:36d:dfe4:387c with SMTP id 98e67ed59e1d1-37c2bc7a4fdmr9216739a91.10.1781503757250;
        Sun, 14 Jun 2026 23:09:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4b:b0:36d:dfe4:387c with SMTP id 98e67ed59e1d1-37c2bc7a4fdmr9216714a91.10.1781503756727;
        Sun, 14 Jun 2026 23:09:16 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2678375fsm11063580a91.17.2026.06.14.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 23:09:16 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>,
        Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v7] dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Mon, 15 Jun 2026 11:39:08 +0530
Message-Id: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: g6LZgHG9WeMp3GTfM-h_Lwa59ks5hpr8
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2f970e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=8AirrxEcAAAA:8 a=qeNJoaxpl3A19PTdgUYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: g6LZgHG9WeMp3GTfM-h_Lwa59ks5hpr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2MSBTYWx0ZWRfX/oaxJvo43EpT
 5lyJqyRRNXjyh5wIAHqDw9QPg0yaXZDtQHD7uL6xnxMCnetJTYyyiKYMHMbY9VTbDGrcXF77h+0
 2oCnC8PL+teRsT1jVySCKETQOqA/d/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2MSBTYWx0ZWRfX6sKodpFy86NS
 0ovTKqOiIn/I24fZLrWIbYTNaj0Ss82dG95svZguRv5oDRlNmBpvA3JIYM5ZoKD2AjaRXaUj4br
 a0rxx/PUyclLQXIY1kb3LUp68IJ9shXwkGjjt6eDFbV19NGHSDCnQYmSdIS2X8WUgfxvLHIaxQI
 Etfn/FVINlwTmwpccQ6vmvZaAeS93o4mR9mrD8LUFD2OBNvuOzBLChebCBgRGylBjCfl8K0usoF
 Vu5Ph4l4LdGWhtGsHQS9lNxQukJB9bgGPbkrr8j30X08F9nv+9Mi4tpjjOOPOEdAZx1bJCmMho0
 kn3hAPCtBnijQRGFFxG8zLD3gguLPLvYvxfqYBSQKmzHUxeVsu9kbhyDfajdtmuLt/G32Lxl5/l
 lnh8Za86dgJn35nxIrGx9WN0pfVojiI5kOLhmhDGC6zEla0xvOFfLdWGt7i+6NFG/8cfMZIhOcO
 +JbxQHhWl3GV/fCbn7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11509-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:absahu@codeaurora.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:md.alam@oss.qualcomm.com,m:lakshmi.d@oss.qualcomm.com,m:Frank.Li@nxp.com,m:dmitry.baryshkov@oss.qualcomm.com,m:stable@vger.kernel.org,m:varadarajan.narayanan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[varadarajan.narayanan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[varadarajan.narayanan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09664683A92

From: Md Sadre Alam <md.alam@oss.qualcomm.com>

BAM version 1.6.0 and later changed the behavior of the mask field in
command elements for read operations.

In older BAM versions, or prior implementation assumptions, the mask
field was effectively ignored for read commands. However, starting from
BAM v1.6.0, the mask field for read commands is repurposed to carry the
upper 4 bits of the destination address, enabling support for 36-bit
addressing. For write commands, the mask field continues to function as
a traditional write mask.

The current driver sets mask = 0xffffffff for all command elements.
While this works for write operations, it breaks read operations on
BAM v1.6.0+ hardware. In such cases, the hardware interprets the upper
address bits as 0xf, resulting in an invalid destination address
(0xf_xxxxxxxx instead of 0x0_xxxxxxxx).

This leads to failures such as NAND enumeration issues observed on
platforms like IPQ5424.

Fix this by assigning the mask field based on command type:
  - For read commands: set mask = 0 (upper address bits = 0)
  - For write commands: retain mask = 0xffffffff

Also update the bam_cmd_element structure documentation to reflect the
dual purpose of the mask field across BAM versions.

This ensures correct behavior on BAM v1.6.0+ while maintaining backward
compatibility with older hardware.

Fixes: dfebb055f73a2 ("dmaengine: qcom: bam_dma: wrapper functions for command descriptor")
Tested-by: Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Change in [v7] -
	- Remove blank line after 'Fixes' tag
	- Add 'Cc: stable@vger.kernel.org'
	- Add R-b Dmitry Baryshkov
	- No code changes

Change in [v6] - https://lore.kernel.org/linux-arm-msm/20260611045757.2841252-1-varadarajan.narayanan@oss.qualcomm.com/
	- Commit message updated, no code changes
	- Pick R-b Frank Li (given in v4)
	- Change 'Lakshmi Sowjanya D' e-mail id to oss.qualcomm.com instead of quicinc.com

Change in [v5] - https://lore.kernel.org/linux-arm-msm/20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com/#t
	- Split the driver change into a separate patch
	- Update commit log with 'Fixes' tag

Change in [v4] - https://lore.kernel.org/linux-arm-msm/20260206100202.413834-2-quic_mdalam@quicinc.com/

* No change

Change in [v3]

* Added Tested-by tag

Change in [v2]

* No change

Change in [v1]

* Updated bam_prep_ce_le32() to set the mask field conditionally based on
  command type

* Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+
---
 include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..d9d07a9ab313 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -13,9 +13,12 @@
  * supported by BAM DMA Engine.
  *
  * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
- * @data - for write command: content to be written into peripheral register.
- *	   for read command: dest addr to write peripheral register value.
- * @mask - register mask.
+ * @data - For write command: content to be written into peripheral register.
+ *	   For read command: lower 32 bits of destination address.
+ * @mask - For write command: register write mask.
+ *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
+ *	   For read command on BAM < v1.6.0: ignored by hardware.
+ *	   Setting to 0 ensures 32-bit addressing compatibility.
  * @reserved - for future usage.
  *
  */
@@ -42,6 +45,10 @@ enum bam_command_type {
  * @addr: target address
  * @cmd: BAM command
  * @data: actual data for write and dest addr for read in le32
+ *
+ * For BAM v1.6.0+, the mask field behavior depends on command type:
+ * - Write commands: mask = write mask (typically 0xffffffff)
+ * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
  */
 static inline void
 bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
@@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
 	bam_ce->cmd_and_addr =
 		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
 	bam_ce->data = data;
-	bam_ce->mask = cpu_to_le32(0xffffffff);
+	if (cmd == BAM_READ_COMMAND)
+		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
+	else
+		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
+	bam_ce->reserved = 0;
 }
 
 /*
@@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
  * @bam_ce: BAM command element
  * @addr: target address
  * @cmd: BAM command
- * @data: actual data for write and dest addr for read
+ * @data: actual data for write and destination address for read
  */
 static inline void
 bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
-- 
2.34.1


