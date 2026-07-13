Return-Path: <dmaengine+bounces-12425-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1P2eAW0+VWq1lwAAu9opvQ
	(envelope-from <dmaengine+bounces-12425-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:37:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF9274EBCC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:37:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KsrVT58A;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=I5ZrecXX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12425-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12425-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F06D9300AD61
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96072357CE5;
	Mon, 13 Jul 2026 19:37:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8F353A84
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971432; cv=none; b=Dlb+V+EXKGQUCgcIS0zA+3+vLizCEnQM4eJxIS4gG/wlUPkO7a3MpSVlyiUZbfxlMFIOM5Yr8k92KGWszWVEjmR0aIZHhxHZ5Ub7+4DHxnqhKllzwVc6zWa0EXwTXEGfvYXMBOtN42C6KLiDC2vDChcAlFWCsowOrFbE3CPIPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971432; c=relaxed/simple;
	bh=VzRE+mW6bIFbzTSbJl62fZ0E1L4ZozEW46P/80rxb0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eXrKjTcLix/e7aMTOGPRPfASbeEx1/FYDC5i6kOjUtABjk4XmXTh2RqiLNMZr1Og3br5CQ7AVpCnGZ1AgrB3IUHBNXlylq3FaYBJagef0aJt0m4w5E8zToJ7a4846SIDVbFRHEEM72QOb5OImoIMEDWg7YfcimdeUCnHXUOVnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KsrVT58A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5ZrecXX; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ988b2275570
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLZiCfxmYB7bwAfCoP9oXf
	Q7q5N7blEMsw29C0ndjAc=; b=KsrVT58A3vyj+5jef5IiPl0i6m8qDgl/iNXQSW
	F3Ev5mFrF3Zv0r6KykFnSlFdvSqPogXRq/+/dVmHJNOe0BfYWphp2R5kzAZV0sAq
	DAHalhYBwgiI+w5cpsogw6LEqmATD2+RKNBZ/7sWSYWh1ZeBme0zjIq8pQ3tqBwQ
	FKWjQU5r1yx66R/96fvRTbj2M9kpjZ6rie001SbqxLEk1xTwJzIEJIzdKYSb8aHz
	QwyJlOSSLF8zIUkw4KI6LPmAdkWxtFwOTTtQ5D4a3g6l7jrBmnvariHb9Silo61N
	2av5kJhNQCA6KkGiILoFnkR7hgn+fnF8HfolkXSR+odJ/b1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p0hm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so5743700a91.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971428; x=1784576228; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hLZiCfxmYB7bwAfCoP9oXfQ7q5N7blEMsw29C0ndjAc=;
        b=I5ZrecXXx17Zd+nzANwRpYQQAAHbhO+fBcIZCAnSsHGX8kwDEucglUOaPdrva0yC8r
         thxVIZ7nvN6q/uB4LcrFgitpqxLWxhKApYty2YrIdibOuP/rrvUCKUQirfO/zTI16luB
         X2rPE72P4F5eLr6r2qeBf2HMoo22lCnV4SWlD8HGn5Bpk1zkeuhMC5CYCqKS+diUTR0m
         aFYsyMxRWCicwnG/noJGOha+lJ69IQsCPrJllaHgxNs+fEkJ8hD8DT47xAI3MlaRIGD/
         7DV4xORxTvsnjdalD5Dpy7x2XUx5YWE02vzFhE8UsAAKDmFHYGVm/eK7/AFrC0/5igWc
         F3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971428; x=1784576228;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hLZiCfxmYB7bwAfCoP9oXfQ7q5N7blEMsw29C0ndjAc=;
        b=UAjVXOf34hR/BUvcPplxg+G1rb1zTNU/T0PbqhlwuBBhFrphGVlbPavVTKjnHee7Gy
         2+3wTMDS7zD0zEAe3PPkhHq0Umo28xZQncvqkpOp4o/se20jw4OwZij0ZPBVAGX2w544
         DUxOQN4+uPqPwqNzwU+UNvO0KInxs8PE1cMAkM8l1FWQ4dY3m5yO56ggtuaUf3vjT4zP
         CEiwwwih57B+Y0KJd/Lix9Nmg74MhU34bVLY28vEXWdxt7fmC8F4zrTGjdD1xkI6JFyb
         xfU3mrax06MN9NCrM+P26cerL1R1B5Ny0qccthEY9yIGkKvgUhL8u4NVszMTO7zbZ6sS
         m4cQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHJkFKvu8UWF1SglFSZN7NBlm1nbL++duZynrh4nqU9eUAER1PAXVQkjkENx00v3QIZmUx5PQ/PeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbCHH8b/wDg0LADTG5MuAWssh8TWBku2jM5WK12bmTSC43cGF
	wnCTKsc1vCGwwf4c3kgXzLmgbWfqrv4qTJkuenUAynfEudoof9NWHmNeOPFjUl1tt/SJ4DBm92c
	KNq1WAQ5KNmtUZYBwkD70xFZc6VsZ4IqGm7Kc7o09Sth1/MuExnBwVa8IorHrh9Y=
X-Gm-Gg: AfdE7ck/rhEgRYp/4da56MJ0Tx3PxI52bFmInbFOvXCoaJ55qq/nju4VHu21KjnHYdG
	xfw4uheR40Sig6ECAk9rI6ABiuj3rl+aUyonFpveejqMF+rfUjYfREz4R2WvKhJaw18QwUszAVv
	th/t0Q3cgmbOP/ZmMphBrnG7c/0W04vi+TQU3AEtfn1+D1vBxIonixw3GgLPwjy8qwysfDZ1ylA
	XHuNUX/TyqLQ1sb6fMrNkUZkKmwinhzyJHeMXNG76tCkl9OyjvaDAlGOZrbNzPJfCs6uGuSME10
	3oociNCfsKH/axH3nBcTC4xRiJt2reAebiSKFDjPZmTr31j4p8ejL+YNl52HGH3DW31pjPuWlxM
	/1Rnc6Lo6KEmwV5kP7th5Rr7KXA==
X-Received: by 2002:a17:90b:5590:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38dc75e6dd8mr9410757a91.19.1783971428213;
        Mon, 13 Jul 2026 12:37:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5590:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38dc75e6dd8mr9410732a91.19.1783971427801;
        Mon, 13 Jul 2026 12:37:07 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:07 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v6 00/11] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Tue, 14 Jul 2026 01:06:49 +0530
Message-Id: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFE+VWoC/3XQy2rDMBAF0F8JWldhNHpY6qr/UbKQ9ahF67iRH
 JMS/O+V04WDqTcD98KcgbmTEnIKhbwe7iSHKZU0nGtQLwfiOnv+CDT5mgkCKpAoaenSZ7bUj7R
 nFDT64LjG0ERSV75ziOn24N5PfzmHy7Wq41p2qYxD/nmcnNjS7uhTPUCjZNZorn1r7dtQyvFyt
 V9u6PtjHWTxJnwyOGwMrIZqW6kZcOkZ3zH4aihgG4NXA2LgUXsTnNA7hng29MYQ1UDGBAeQRli
 1Y8jVaAA3hlz+YRizzmCD4P4x5nn+BQdED63UAQAA
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=4797;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VzRE+mW6bIFbzTSbJl62fZ0E1L4ZozEW46P/80rxb0o=;
 b=5CblA/c4Gwk5lkwo72Dup0WlNN4P9wxPg5gycbri4vZAkzBLE1OasX4GSb2BXTcsQuZPvhqo4
 hZ2+Kx0nK3IDjgPfKRvsk/JeAOAxyJqzAZuLnQnRYnqdxflqWojVpmL
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX1sJT78Qfrsm1
 SBh8o7LJQ8J2LWD19LLAeRtT0jTLnbsxim1hXM5F8WyZbsTeSxgQLMFF3jJiLisNN2ayCLN/Emv
 1R9K2boyRDBxmbS6b+Cl7sX3d5mS/gc=
X-Proofpoint-GUID: twNgr92QtG35wU4a6hDWYnZI8BESzpvn
X-Proofpoint-ORIG-GUID: twNgr92QtG35wU4a6hDWYnZI8BESzpvn
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a553e64 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_oGjjxQr57uqCMXUvsYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfXze1g4VWuEO2u
 wL5At2pxR4eSPtu3OqssF1P3ouGGFEZZSVCkX3h+0Gjr/hmx48zc5q2yVlQUjjmrxojD/F/s4RD
 eNXwxCLhURcENnv4/bJxLGwPhbUAICNOXk5oghwXxE/9218r6viqBi8gQ2OQ7hh1HXULv1iaEID
 TtJWyOoj36Mq2qqdrrnIOexT7tDtUDkkc0C0jZiYQnJJI3SxDAzoO9AhesBEkjsbx3RutKgX5K2
 Oc1AlxXsyOd2oKxnfHsOPHLSMjn2mJwR3eusgJI3Lrk5N7vzrcsMfakNzR/q2iF0h9kqhSNUVZV
 VDZYOM15QRAQ0O+zhdh+S4huoANoSf4d52h6c9e/zxqW5xMPmp0vbqC98oIiAm7psEeklch58Jn
 mM7XiweJnInApL3Nx4ifBDpFCWLVGKZaYc0vwZIwpyQWWA14bQ59ZhsdAxfkcRXgylgOenojk7U
 W8r+rMagbDVeT99Ijzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12425-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:xueyao.an@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:aastha.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:raviteja.laggyshetty@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:gaurav.kohli@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:yepuri.siddu@oss.qualcomm.com,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECF9274EBCC

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
- Gpio-reserved-ranges to tlmm to mark GPIOs used by the SoC
  internally and not available for general use

This series depends on:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/linux-clk/20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v6:
- Collected Reviewed-by tags from Konrad
- Reworked WiFi/BT enablement into SoM dtsi files, including WCN3988
  PMU/regulator supplies, Bluetooth and WiFi enablement
- Updated gpio-reserved-ranges to document reserved GPIO functions and
  drop GPIO115/GPIO116 from the EVK reserved list
- Link to v5: https://lore.kernel.org/r/20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com

Changes in v5:
- Split the WiFi hardware description into a separate shikra.dtsi patch (Konrad)
- Moved common WCN3988 PMU, Bluetooth and WiFi properties into
  shikra-evk.dtsi, leaving board files with board-specific supplies and
  status updates (Konrad)
- Added missing CPU OPP entries for 768 MHz and 2208 MHz
- Added gpio-reserved-ranges for TLMM on CQM, CQS and IQS EVK boards
- Collected tags fron Dmitry and Konrad
- Link to v4: https://lore.kernel.org/r/20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com

Changes in v4:
- Updated commit message for first commit of the series (Krzysztof)
- Collected tags from Dmitry and Krzysztof
- Updated wifi fimmware name (Dmitry)
- Link to v3: https://lore.kernel.org/r/20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com

Changes in v3:
- Add missing interrupt affinity cell (0) to GPI DMA interrupts
- Link to v2: https://lore.kernel.org/r/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com

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

Komal Bajaj (4):
      arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
      arm64: dts: qcom: shikra: add WiFi node support
      arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
      arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm

Sayantan Chakraborty (2):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (1):
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi       |   74 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi       |   82 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1682 +++++++++++++++++++-
 7 files changed, 1906 insertions(+), 14 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260525-shikra-dt-m1-082dec382e7f

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


