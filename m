Return-Path: <dmaengine+bounces-12044-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lgi8H0ysS2pKYQEAu9opvQ
	(envelope-from <dmaengine+bounces-12044-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:23:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0E711362
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Tbek1Em0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DP+9AxC7;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12044-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12044-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6BF032C4712
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300B35AC24;
	Mon,  6 Jul 2026 11:32:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABD414DE8
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337528; cv=none; b=MNKu5M1ufb2ARKHEBFnz5mx1AJGhy6zJSOFOZeGosE1buUpoEuD1af82I/hk2dU+fUXCq/gv6dfylmGFciylJ5hvOO47k6qHzSUey31MwoQibG4ELd8fkGlrMa6tGow+RwkIhW5zEoHpFsiRcIN48L4CLBBzZDUKsYY4HJON5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337528; c=relaxed/simple;
	bh=wsN4Qj8nyQ40xLi0czEZnpsh/82ufhgYUDoGmikiwFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+1h/lf42+lcQJ6xqKhWiApN2vgQmHdrfXALf/ebHe3qkHMUKn8VIQh/ytkN4xUdd6X+I9sVrde/DBRa181f+ltqtDiwCbW+7px3MmnwywYKbePTLVsfYsYUfXM+rLugCcxxUZ0d6n/iSu0r5mYF7OvfjpN39HJouT0YOD+jyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tbek1Em0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DP+9AxC7; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxECp366750
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E7Q/PsRxa+vqndhp+ONNBD
	gCCG74mkgHXpn3JzjDtP4=; b=Tbek1Em0iDoveqt4PIN//nwZwCzG9x9tf45bR8
	7S6fGZRNwr4irn7E51jjoFmI3ew4rAib5eIETnV0ddNwIutLjGuSM2z6C/4MRN3H
	p89q+j3Wp/eJmIDj4jQ7cAAmEnMXUP1EG/w7k5cH/OKrMEqBoy+fn+qDyBDebiUL
	xu/IvVi0N65DUpgXE8kur58+T4tvLbY38agvgC1kJeqL76C5uaP5UqSrX0xVFXel
	TLldE4XuugJIOZ8N1rOMZG8EpaFgGwM+/LwS7OccPgQ3ZsGmUXgzWNxMhRSE6cVa
	FrYzoU6eKgqxw1LzpaUd6xKOIeHZsi8anLpAJkGCybZ5S+jg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891urn0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85a298cd62so2384971a12.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337525; x=1783942325; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7Q/PsRxa+vqndhp+ONNBDgCCG74mkgHXpn3JzjDtP4=;
        b=DP+9AxC78zBe3nn/B3hB38fnNNP3FwLrXh/6Yh13JTqjwwlmI1clAKWNyV00PbdU85
         9177LmyogORdEG3jhPTlYk2OV9QFV6sqUvMPbyyatEDYL1iqlqzpDzM4GSNv7ZModItb
         bBgREXG+7HXZejX9ZMsWfNnfoyvJWk/n9RQgHwk0oFa/M44SvSo/WzPb3/hmydEx9w1K
         ugbDBV5EcyHy4gyXev+QvXJGI5kFX+TxVh6/imiiLaP8qlua3qH2VeZjcSF8Ledh8Abe
         tCANGkcs7TqRbxtBpPcx3rvMfs7Xjq9Avz5d178I9vfBvHsD+HgbBmye+X0nG+CNUb9R
         a0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337525; x=1783942325;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7Q/PsRxa+vqndhp+ONNBDgCCG74mkgHXpn3JzjDtP4=;
        b=U1WlE8U5c+LCNLmEjp9zkYXSp1TqE3wUReSvhNfI7GawvWPEhBsNcf9oJeonomAJs5
         He9rVhsdO+gytoMKwlXTT/b6p6KfDd0lAtHzG9TkGA45akuE21SwSu7OQtJ23Qd6HsgE
         pqsQBCxVIhMroOQbJnPhwd+RNW/sBQQYzEti9166n/m7N9I642o+1Me4IVTsIvVVdq/q
         mfwen1TCrBQ/Aimpv9R8Nn1Ma2oqSCwl3Za2nL9cd1kzS1KSGcNaNZkqFqd9WZUTo/AA
         r8NHlYqVJDQNNDk5GKniN76keGEpDaikDljXNmZgAuT3kwolJ4f8ktFEASwe/4yZDnEF
         FqWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4qkdFFIjCHoi+i9tNdHaa5lPBgcenaJrRT1Apyar/fnnRlkBtdgzbn5zn8h2LjrLyRvg/oEzsFc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJGBR+7+Ren4/019aVA3aFilR9EfXOdrGbCWKiZZ23mHlKS38
	8eeaVIajd/Vtu6M7f0MIJSqYCHX4cAQYa/xZ9j8BTxYC1HkHmysGT6jeMMKVVmzfZkFY4Aw7W03
	FF1NuMd7r+4AWP1vAyT1svvIRAW7ZMJiq46AGR1EsTG2PPbk4a7pBIf1c5iDGh20=
X-Gm-Gg: AfdE7ck5DExKaTof7VpgEZl2r7hXjjsYvPAvX49vStEAPubwTXdjrY/PTDkqaJlbJ/E
	9OtVqS04Yk1DH3fNhA744Key2/DFQB4xYYbIu2EFegiOKIO87On9fhbSGUo9ewo1h0oRUINdNV1
	79R+Iz6z6b9cYIkah8m7pBWhXw4f8/NVKsUwMxjkmAw3tcNMjRsyo+Mopqr31IFzVzkMv1+MGLz
	5XGhG8oB0sw7BWHpzHRWodSEHm6moSLJH1OfC5bgGZFfBBClAPS1CT8M6jee2iEqE7MnrUL+U0l
	38hSQtPjt7RO1OqWlFdCR6yQhzEfsRM7Za4tegBWs4XhppP/2ccIaWvcMsP79pqUYNhVKua5BtI
	LqQSGJNLafR0Ju7Wi2wHS1epunt6IGyBnQOtoH2gRp/T4
X-Received: by 2002:a05:6a00:929a:b0:845:eb88:3d86 with SMTP id d2e1a72fcca58-84826e54b7dmr83340b3a.48.1783337525080;
        Mon, 06 Jul 2026 04:32:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:929a:b0:845:eb88:3d86 with SMTP id d2e1a72fcca58-84826e54b7dmr83320b3a.48.1783337524574;
        Mon, 06 Jul 2026 04:32:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:03 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v3 0/6] Shikra: Add DT support for ICE, RNG and QCE
Date: Mon, 06 Jul 2026 17:01:28 +0530
Message-Id: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGSS2oC/3WQ72rDIBTFXyX4eRY1/ksZo+8xRtCrWd2WJlUTV
 krffSYZDLbui3Dk3N+5515R8jH4hPbVFUU/hxSGUxH1Q4XgaE6vHgdXNGKESaIIxZbjdAzv0bQ
 QL2Me2tWWPO6Yk07YjnArUBkfo+/C54p+ftl0muybh7zwFscxpDzEy5o908W3xQhG/8mYKSaYU
 MEBGgDi/GFIaXeezAcMfb8rD1qiZvYDU4T9v/PMCk9KquqOdUzb+nDO4Rfvtu0e/Xkq18lbIdT
 7lMx6nX31uAZJyr5TsMt4lgvZSrBCO8uV+rPp03KCOxjW4AC+9X0PbZrGcYiFpguNGiY9VVRZL
 e7TrCmdlp+Q91VjQPOac1dLLhSIRmsiO+W0d7SWjdGWgAAuSsPbF7p5RyMHAgAA
X-Change-ID: 20260701-b4-shikra_crypto_changse-f2d6d5bf04b5
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: t55Yj4kuhH6Wm65A_HSUVtkSvPo8DI27
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfXyzIpIun51wLO
 +fdtWuVeIp2KJFZtMt0RBJK3q9qeJkVdWW1/S/s69EmAaBWw+bjKpBG4rZYSngm2MqmFstqdHYW
 eSM6wSCZUrvs7iqbhglny0+X6VQcvTg=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b9235 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=FNyBlpCuAAAA:8
 a=J1Y8HTJGAAAA:8 a=psUvNacZHcIMRI98aYkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22 a=RlW-AWeGUCXs_Nkyno-6:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfXxNhPnTQLQG8u
 wUxn3i7gHGuZOl0FsTklWgMwR/9SA3Pyc6geD/GcLm76zfefUY4WUEbpmynuUVuyMUUsy8lVn6M
 y9LJ6gdjfH5MD6KLhnejRsVHA/S2a8ezKlRr7up9vXJU9oKRuq5aO60mqMvBVZn+9db8kT4wID7
 apzwd9uTRKnW8RnrPviXoVks7yzzaSZ4JjwnxbGsFbG2P2n1pzZ+jMyKX3PWYEt7HIdfBNdpcKt
 fN5CXulztjCkoj+m7r0sbSrjc8HMy9c5b498WcSlpWriasEf1KqHreJnWlyikG/83Rmifjl4D+0
 0ftxRlZ8gZWvfQkZ7DbAGRxOJI1qqieknqNhdWa/QTvar6Th6//SA/fsQqXylYkjkZ9JFlWCye2
 4KMEnjsZQoOon9SL/15eQ5Zf0+ylaoRFcEog6cPI7GUrxgfG5+7kCwx5ExWIeYG6z0NGes3Wfur
 fc5zSXIoT6Bqeocae7Q==
X-Proofpoint-ORIG-GUID: t55Yj4kuhH6Wm65A_HSUVtkSvPo8DI27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12044-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFF0E711362

This patch series enables SDHC ICE, RNG and QCE support on Shikra,
aligned with how similar support is modeled on other Qualcomm platforms.

These DT and dt-bindings updates were previously posted as three
separate series. Based on review feedback, they are grouped here as one
crypto-focused series.

Previous threads:
QCE: https://lore.kernel.org/lkml/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/
RNG: https://lore.kernel.org/lkml/20260514-shikra_rng-v1-0-4ea721a1429a@oss.qualcomm.com/
ICE: https://lore.kernel.org/lkml/20260515-shikra_ice_ufs-v2-0-2724a54339db@oss.qualcomm.com/

Prerequisite series:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
- https://lore.kernel.org/lkml/20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com/

Validation:
- ICE: driver probe at boot
- QCE: kcapi tests and driver probe
- RNG: validated using rngutils
- DT: validated shikra-cqs-evk.dtb with dt_binding_check and CHECK_DTBS=y

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v3:
- Fix commit messages.
- Collect Ack and Reviewed-by tags.
- Link to v2: https://patch.msgid.link/20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com

Changes in v2:
- Add fix in ice bindings to specify 2 clocks defauly for non-legacy Soc
  compatibles.
- Update commit messages.
- Link to v1: https://patch.msgid.link/20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com/

To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org

---
Kuldeep Singh (6):
      dt-bindings: crypto: qcom,inline-crypto-engine: Fix legacy/new SoC strictness split
      dt-bindings: crypto: qcom,inline-crypto-engine: Document Shikra ICE
      dt-bindings: crypto: qcom,prng: Document Shikra TRNG
      dt-bindings: crypto: qcom-qce: Document the Shikra crypto engine
      dt-bindings: dma: qcom,bam-dma: Increase iommus maxItems to 7
      arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes

 .../bindings/crypto/qcom,inline-crypto-engine.yaml | 24 +++++++---
 .../devicetree/bindings/crypto/qcom,prng.yaml      |  1 +
 .../devicetree/bindings/crypto/qcom-qce.yaml       |  1 +
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |  2 +-
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 52 ++++++++++++++++++++++
 5 files changed, 73 insertions(+), 7 deletions(-)
---
base-commit: 9ac84344d36457c598806f7d8ed1369a8b0c5c45
change-id: 20260701-b4-shikra_crypto_changse-f2d6d5bf04b5
prerequisite-message-id: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: ac83151a889855498d36288ddd36216d451340c8
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-message-id: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
prerequisite-patch-id: 0118397958b85e4297b47d6553ba4bf5b84024bb
prerequisite-patch-id: b6724798e8b73fb2182d11bda2a7aaa58976c7ea
prerequisite-patch-id: 4101033ee8eb0bc79c8dbc4a6c636cd527bf3bd0

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


