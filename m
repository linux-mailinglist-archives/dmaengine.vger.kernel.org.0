Return-Path: <dmaengine+bounces-11051-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P25BEAsG2ow/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11051-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:28:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F2611CBA
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96D42300ACAE
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473D313E34;
	Sat, 30 May 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p4HRyasd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/Lz30Nv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735629D291
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165679; cv=none; b=AZlwHWwTmbBaUjZ6pAoNtX1GGPhgRsBV/OEK3/JyW2ulyabWseXuACFwUMZEnGxPQ4DTcUCWG6CLvHYyXQce48+D7mzDd5MRwmCJjsArmVAB163A1UeuWnigrzjE/aaSpn3d5AO3xS8W+ciwHf3UxSMm0jtvdkr9+wFZ6I5nmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165679; c=relaxed/simple;
	bh=VLXZpMILUq11X7qFw+Zk5xYRTfuiih2s0+m054OPu70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J3InNG5an74GGK/hJwUf1RwvfDMy3GyaqO8uStT8V35KfQSDc2iAP74RSq29TdzO70g7RjtGwpThrM+puzbcEeaqmdOkq6HDGC/EGBgHTbxDPxVkNSneSaoN62HuCNS7eAlOH/VWj9vL6X4ZWvcHW6z/KzpwvrmZ1iZop4btHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p4HRyasd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d/Lz30Nv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOS5I3280285
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W6f8qln8rcTV62Se70c3op
	LI1ZWHz4BoH0x5DHMMPO0=; b=p4HRyasdqUhxLPHN8qbQUpGwhaQ/ojG/HJrSTA
	PKpO1BqLG0Sj+wVqPGbRwM7fBWdZKNpHNyYPPE0tZ0YuZEpVfOsn1QnYcYi+8NUf
	jKmWdsAvBgFJRi33hUmf/Ado1aG7tN6c6+pZ6cghrjoiKLJejLKEehGDSVNziuDf
	2Njd91bUNfi7kFyh4PoPXaLaEUC1vvu9sirbNj7cqEqR2E21gsB8mbejmIj8wAec
	L2xAbQd0W3+qcgHuna5Uvizsptpog/LwH3DHT4PfTXchTaAXcEn3dUfc3yB4AN0t
	J8vHUKpk27A0TrOqe8lhvBl4UvAt7jzh5mg05mKkXaQZPs7w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f9tt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:27:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf1845bddfso21755165ad.1
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165676; x=1780770476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6f8qln8rcTV62Se70c3opLI1ZWHz4BoH0x5DHMMPO0=;
        b=d/Lz30NvU2b8vAoHmp3uoq+NvFqgbeQz05cV2x7mXh1uzgxF3RJjhdjV4mVZ/uUEBF
         1bUiFTdaaJpCbHHTKwvcl+VwnWBmTRY+udxb4SrHhv445p77zyWHQ/lRKc8MfLNmmy+A
         Zf8i54g07wI9kjEPko7zrrTQkAma61h1a97dQ0yCGNKb1aIUf/tVYhGZnTO7fqlgN+K/
         l3stes+f/B3WECgWdBn6VbnS6WG44r1Z8kIcsDGFScopx+QmZHVzgp/Nf1unWIZUCOxF
         qeGcz9Q4npq+ONXeLoAUcq1r0FQptmkwb6s9muVbHDsMsyD7JLIiLyoK38N24Qp8PzQC
         74Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165676; x=1780770476;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6f8qln8rcTV62Se70c3opLI1ZWHz4BoH0x5DHMMPO0=;
        b=MuJYp9g40faF7hgXEHOxgn4w+JXGCkpEMekr5PinsIk0Z+W5fCMSdtJN2zYaN2Tnq3
         uoeL5GxCvjESJ7CbkGh708xLwz6UTHHIvYqrBzxaZFaRW+W0k4EAgWgy+3gbcorBOZDb
         WPLYuj9bguwbIIIyMnA0ViLqBqIOpJy4qaqIFDKLB9InhmADpdz/enVuP7PDHnjLP7+i
         lbcq6YS9n+HRzb5pdvou5UuIAXAVLi3GQBoqmF8E4WkNBKZgpcbgJSA0V3XatmGqlBdX
         H7lpW2A9EJHgv41em+CIWmP3uCy7PBC9l/xFGXh8eapXDZrhLM90rA+tJFpFFn9XiaHc
         q1tg==
X-Forwarded-Encrypted: i=1; AFNElJ/EuLTPLgJJYdGHTnpGNq1tSjULwM1vhmAG97BVVraEafYhsm5IfWo1NtwlgEJ/GTHJ0Ai69dWzN9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBf+O9x+l8pQmKQ6tggEFLDWwx1wEQ4g3dCbJS2wr/NeXHKSm
	uO20jOtHyreCNMzBEQ3AoYJJnwEWUxGtWenOkHPWxhyC/n7pjsPINKuofdCgtnGlp+QWHPMm1mw
	upDQK11e5Ff/db0GpQkrUFaf8tRKtnek3qFdk9RaaEKLX91zaX8ZiOagSizSy8UE=
X-Gm-Gg: Acq92OGGWUX3C75OCk+g4TdK9UMnxZuBopVOryqf6v96Vox5a8HTXvNYCnSMGNqOXIu
	daS9dXdsLHTL3XMvcuMUGhvl1PxV9hYiCvpJcdGsFjIg/4T46+MrvVWUt4T/MA+hDJZrp6gvBWv
	iC1B4/mVT0jRYThfcyAsmhl+minCTQGl/nNjvhCi+OKVtvyvq8opjGRHkyqx1TM3mwqZcTP/2i9
	iPHw9uxY64MJwtqhxmUSHi0j9Z5Dx7j7Xo9XOyJNgBdncV+Weg/r9T2z0wsVZbJOMrDq4i8hNNL
	vz7O4c5EM0rlnT8WWz7j+CvdlwyDulIbNyLU7Qf7SW3zTxNR7xJezD8AgZ/ioR0kvHtM7bgSQ5f
	T6QxhgohPTojcsjgY8a7nAWs80N8z3U+pTs8TchzawzVEKtA=
X-Received: by 2002:a17:903:22d2:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c0a36046d6mr40917895ad.29.1780165675511;
        Sat, 30 May 2026 11:27:55 -0700 (PDT)
X-Received: by 2002:a17:903:22d2:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c0a36046d6mr40917635ad.29.1780165675025;
        Sat, 30 May 2026 11:27:55 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:27:54 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v2 00/10] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Sat, 30 May 2026 23:57:18 +0530
Message-Id: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgsG2oC/22Qy27CMBBFfwV5XaNk7HHsrPofFUJ+jMEqJGCHq
 BXi32sebVmwsXQtnXNH98wK5USF9YszyzSnksahBnhbML+1w4Z4CjUzaEA1CMjLNn1my8PE9y1
 vNATyQgN1kVXkkCmmr5vuY3XPmY6nap3un//S2nFTtu2TMnQYTCdRKqn6WbLnK/4A8QvkQx49b
 4IViB6VV6afxWsG+FRoKGuXhpCGDTc2Ng2SdAKon9uXEMhH0ZoOpax3giOAjSSj0xEflLOFuB/
 3+zT1C9+SdyBMtEKiQjBWACAKNNF32ilDzgQtO3bdZpvKNObv2/LVdR3n9chz3ZlHbK3RQgdn7
 ftYyvJ4srtr77I+bHW5XH4AAyiTvcsBAAA=
X-Change-ID: 20260525-shikra-dt-m1-082dec382e7f
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=4358;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VLXZpMILUq11X7qFw+Zk5xYRTfuiih2s0+m054OPu70=;
 b=pZZsiqs0rmCwbQT3CbvxUtBCC8gyMg1LKGlXU8v4uq9rQl8mXb0GchoX9u5AdjiuhlA3Zo2pw
 OLeOpMSGsjVDf2djwt6JAHW2Sm670y+UwRWlms6frwnagY6Yxgdf6BY
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: YBnqa0vzeObuerCx6vbXT2voXxDHmvPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX2/iHDoutkqli
 fbPIw9I/EypEssFskhMZoC2tsnDgN8GvsUZt2mKriCNESj2dU4+2gy1wQHhW7YeYcz0bxrBxOrX
 2jfK5FNFD5Mlv47dODyTubexMm5HczIYIYpinpiq0Lqunj6NQHYi/gYTRPU64CbRAVSlnlga8um
 TbfWW+LZr+cEle4tsIVZr8MhJ7tOaWj7inwP9YVlTpmF2LB3+FJzZnTR7VzJcbn9JlEyu6NG3lI
 zkEAEhfomETK6FZ2VOE9x+fVsS9juEZZY18LGp+s6RASExiA/m2bOItvIF5/o2PUq+fweUyHVyS
 W14VE7dh8EBWmchikwkPu0TyfD2hJoO9vG8dqbroYfU9/Zu+2TVFf0wkKiwcU/tc6/s9cBaebbp
 PSkGfAyR1u+BPPxXAZJFXGTXy6KoqA24CocBXnZCFCbvUjS/5iWBYugSPbO5oj6xyKJZnpBN8BW
 VFsm3gK6P8v3obO+Wbw==
X-Proofpoint-GUID: YBnqa0vzeObuerCx6vbXT2voXxDHmvPp
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1b2c2c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F_wByC5qsg8vutzaSOUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-11051-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD5F2611CBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend Shikra DT with peripheral and subsystem support across all SoM
variants (CQ2390M, CQ2390S, IQ2390S) and their EVK boards.

The series adds:

- QUPv3 serial engine configuration
- cpufreq-hw node for hardware-assisted CPU frequency scaling
- DDR bandwidth monitor (BWMONv5) nodes with OPP tables for dynamic
  DDR frequency scaling
- EPSS L3 interconnect provider node for L3 cache frequency scaling
- CPU OPP tables to drive DDR and L3 scaling per frequency domain
- SMP2P nodes for CDSP, modem and LMCU inter-processor signalling
- Remoteproc PAS nodes for CDSP, LPAICP and MPSS subsystems
- TSENS instance with 14 thermal sensors and thermal zone definitions
- Bluetooth (WCN3988) node with board-specific regulator supplies on
  all three EVK variants
- WiFi node in the SoC DTSI with board-specific power supply and
  calibration variant selection on all three EVK variants

This series depends on:
- https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
- https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
- https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v2:
- Collected Reviewed-By tags from Dmitry and Konrad
- Squashed cpufreq_hw, EPSS and OPP tables into single commit (Dmitry)
- Removed labels from CPU OPP table entries (Dmitry)
- Squashed CQM, CQS and IQS remoteproc-enable patches into one commit (Dmitry)
- Added WCN3988 PMU support (Dmitry)
- Squashed Bluetooth and Wifi changes into one commit (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com

---
Bibek Kumar Patro (2):
      arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS remoteproc PAS nodes
      arm64: dts: qcom: shikra: Enable CDSP, LPAICP and MPSS on EVK boards

Gaurav Kohli (1):
      arm64: dts: qcom: shikra: Enable TSENS and thermal zones

Komal Bajaj (2):
      arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
      arm64: dts: qcom: shikra: Enable Bluetooth and WiFi on EVK boards

Sayantan Chakraborty (2):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (2):
      dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Shikra SoC
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 .../devicetree/bindings/dma/qcom,gpi.yaml          |    1 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   78 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   78 +
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |   15 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   86 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1679 +++++++++++++++++++-
 7 files changed, 1918 insertions(+), 20 deletions(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260525-shikra-dt-m1-082dec382e7f
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v4
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: 2acc300a68ed8c5364fb5f2f7d28fc0d56ab07bf
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-change-id: 20260513-shikra-rproc-0da355c56c69:v3
prerequisite-patch-id: 39475cddaf673b2cbbae703165a782916f199885
prerequisite-patch-id: 6f7f265abfbdffdc0a1fdc5a7e08929e4eec5b7a
prerequisite-change-id: 20260512-tsens_binding-9af005e4b32e:v1
prerequisite-patch-id: 35141047f44b4845f9d94618bcf26ec58ab4a0b2
prerequisite-change-id: 20260524-shikra_epss_l3-522afe4fb8f5:v1
prerequisite-patch-id: 9e0a3b4d7b2033b39287b4382ba3c0c856a62e77
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


