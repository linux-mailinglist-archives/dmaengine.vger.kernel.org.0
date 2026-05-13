Return-Path: <dmaengine+bounces-10414-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAEDMy1qBGprIQIAu9opvQ
	(envelope-from <dmaengine+bounces-10414-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 14:10:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B32532CB6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 14:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85EC63059306
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B57402442;
	Wed, 13 May 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duMB3yix";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iF/8bqGb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFB401497
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674211; cv=none; b=kgguwIFjBX1Oq5iXOEDMzY3Af3FIUkQcSxHWtcz/4mG36zPg7Dbgl/j3XNRHarUbE7Ch3ZP2Bw10Ej604IDevENzKxv6j65UZMI9IDbxWJLMR8D2ZKvvuHQtPQA5cA+1+7tkMI6ih329Jd2g+1eHvf6tLISkn8X3GWkxuP9InGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674211; c=relaxed/simple;
	bh=BxcFsJDDPMfPmeMRzH5u4RozaCkDIL9K7l+mYCQe0ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lco6r69AOEqcLGW7Aoxx9UU9w2Gn1ytrRVcmXV6KMlki5fVmlkL+NwbQU9Vj26Yi77LL/x86fs5ugDmXtxwWRurPJ99k1doeelh6yijAr8f+JU5LPyLnHqvC/Lb2Vmsk94YNC37GQTzjAU0uZvkqEuAPn6Tz35miDlSMzFDfqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duMB3yix; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iF/8bqGb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAWCuJ2321270
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 12:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u5/wQQP6k7HnfbIPp4SiMU
	w0/4CEYgu6rOXikREoOQM=; b=duMB3yix8/y0I9BjvScr+Cmt2e53BzUTkAac4+
	gPF0B+bRD26RcEkWCKd7hUQgFytfUNXNOkf8gMqdj3YvsDvOEVikdJ1g2FI7enwY
	3hajCAiNCIwxiObwXEbZ+pJOpMky2zYT4E6jXI6uono8WbpKBDqAlcQH4K+eMHI2
	CPnuCokG/ROMvkbrMntSluvj8VtC1plDlOi5CDSflw60m9gO4o+kNwyG+sLJqF+9
	dp6f8RZYXPOuyqn/fJT7xdnCbZZrM2Fb3n4pTLxyGy+2Tc7hPFy35fDWcXtMjI2O
	mUnMMgoQBsGlK9eYBvWpLfHtb0oxdQ91wg9YGOL2UiecwBsg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgu9u1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 12:10:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb6d713ddso33157361cf.1
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778674206; x=1779279006; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5/wQQP6k7HnfbIPp4SiMUw0/4CEYgu6rOXikREoOQM=;
        b=iF/8bqGbedNYojt0OqAosqHTUeL0MjQltak1OBcEE5oAC8Fjb15p85IXnla9wZxnHM
         PJpRA9ITxrhiFw7BVpHtmNUhncXa+Hv5BPMDtUuFkhyvmQDbgEavJ2QmM/khBivIn+P8
         0I7pJ9w4wzNEMNDcuL2pNMdtTjhp1WhzNsskdA13epyA9g2n9+E2qeKsOxD9sPRvMVc3
         xNMq9szPiYAiIfFbYtBZeICHSklZUcfsLvz1TzCOK6CJOZz2QKTXMlVdr+86XWDq6guI
         To7qBicoJB+j8i/Bz1ZhPEgx/GvrgSZK9kQKLP2btljSBNwpiGGPFNj+PqAzLVDi0i9N
         prnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674206; x=1779279006;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5/wQQP6k7HnfbIPp4SiMUw0/4CEYgu6rOXikREoOQM=;
        b=QaMEB9ebaS25gqcPrZl6yPr6Np9AmyP/Opm/D+ytbDdKP+Adqq2sK2jnu5ENV2u6kP
         P9G2MEVj437koiLonMaUjYmv5SBx38yGHtjGMOnwkB28cnRvjQ1G92olJ7FtJ2jIi/Mz
         KVZWBMlMXcG3s01D99QfIMsBp3swzZn8LTqsR8y/adioyFjlN9AdELzs6k6SJQBWifde
         1VT1wbZ6+4IHHFXTCST5WGWnp/mqSukLIKMx8VzXzNb1/KWi7qDO6O5OgzwEM2EfncGT
         YbXhcevvAkq4cxmewuDYLBikKjSYF6Vo9BfVaS71VV5OfqwA7eqaeB9CJ+ROcVJFEnyV
         0htw==
X-Forwarded-Encrypted: i=1; AFNElJ/PpWmQUd0VG47gpE0mnApXIbp/ZcICj/nGNVqRaWFz348/C9To1Me9RSUGDhimufaQDYMk65fF5kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YLYPNP8WLUIG6TtnLYde3LgHxK5q3AVUN4p8O3tsbVT3bNi9
	d1IHjhvT+PgIBuXhs4OUiSNuVXuSIB41mYHtlJjD5RvmHwADOv5SarholMY8cPvbLxOoC0N7ClX
	D+9QSgFLaQzHe08RlU5sFHAaz9kFIZlJKKQ/NwGkwumlMkRlc4uXbeFZOtjB9+zo=
X-Gm-Gg: Acq92OFAEQLbuT67jjOexmbZxI+/pdYyqObqKHOfMHk9Rtc9Al6+uSv6mzgzEv1bk96
	NlYN9yeOxq7s8aKRYJucQun6d9Tn7x/Cr8+vqOp4moYOMhjniUlm8I+3C4LUeBWt8ob6rNTznr8
	VFWUfstPhR2NGkSwtMwQ/uBu4CQmsGyvOXpkrKY/8eopmMm+y8DQB5JWziv4vmxFAxaC0DoQ+gG
	Ki7Xrj9bYxq6i8LdbzV4GrhgCykT2dMFmWpWhsVze3/bZk6ikEpK5Cw0hVK1AXvngZ6mn9cQWj5
	0FUWLB144D5oSE5fulW4K910So4pCimYuPeM61ZQasXzMuojCHTlmx84Rm4m45A6UEw44W16kFL
	OzA9QGHTOr9EhRXkbpmuS2a0n8Avb0A==
X-Received: by 2002:a05:622a:5807:b0:50d:8b23:4948 with SMTP id d75a77b69052e-5162f5f8d28mr36819061cf.46.1778674205971;
        Wed, 13 May 2026 05:10:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5807:b0:50d:8b23:4948 with SMTP id d75a77b69052e-5162f5f8d28mr36818321cf.46.1778674205404;
        Wed, 13 May 2026 05:10:05 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm40691056f8f.26.2026.05.13.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:10:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 13 May 2026 15:10:02 +0300
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the Eliza GPI DMA
 engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-eliza-gpi-dma-v1-1-d8e37f026c36@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABlqBGoC/yXMyw5AMBBA0V+RWZukrVf4FbEoBiNeaREh/l2xP
 It7L7BkmCxk3gWGdrY8Tw7S96Dq9NQScu0MSqhYRDJAGvjU2C6M9agxLqMglCqRjUjBNYuhho/
 vlxe/7Vb2VK3vBO77Af3QyZZxAAAA
X-Change-ID: 20260513-eliza-gpi-dma-6b5341271f09
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=BxcFsJDDPMfPmeMRzH5u4RozaCkDIL9K7l+mYCQe0ic=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqBGoa+FCgBaWjPT/DOS5ogvV6nNkvqWoZhwpSD
 k8IbVf9b8GJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagRqGgAKCRAbX0TJAJUV
 Vs1lD/9M2L2ek/DdKbXZWa1dKlsqMJAn2hymT0TFPTMIMBEpMMdlH1gzK2P2SwOnZDxbYNi8Nb8
 i/60vNTPiAbQ7MH0RYCvIimdwG1ihd0V3VUPmTl8ou9EYnVwgspwhPOd1avpelt/LuqEyouimtj
 D//nW7kWnRXYecC1oEqXdZuDAq2cK/v0Bnw3kybNh8Fd39cB8W2UP7JzIFIAfV3FdXJb9SZe2rw
 RyTxQnhxNvn7bnpLnm+P4da2EnlhhTA0FXpoJKhYXnx3sc69tJpEpWMtJTJ3uG5i1kkdCDQXoVz
 aN/y/fWrSvVWOBspjqp9bvlvrdPJM4Y0uMJ5wpNoa1Q0g2k1WfsV2yaZemtcLgOyZVX9GBL6PhZ
 y0uvMBriao4Z+SlKrmoOGil+yF8jDcacCfloE1g+BrnOWbDco0oE7CjzPkmDydYWYmeALguRZxI
 q9OJz7adwE8Z4Z6W18+2OAziB8ui9ZV55yHt6drTFPzZqyx45ICXWom1K2FGNmpNirJdLB1Iemp
 whKZg5Gs6M5UXpbTe+scKWunJGNLlqOzZ1RV7sAe18NDgMFy4vTcJSFAd0kkrag2QuVNc95J3i3
 EoLM08dcc18eoqP7M21szfqI7iUgK3Fqc8K7RZ5WxvxPyjJGQL8FrtDxN5rPSYaegcjFc1weiBF
 f+gTvvYvZXAN30Q==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a046a1f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CCA8mRsehYleCwTCPhcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: iKCqYuGESGeFkxRsV4Hz8CLLGsQiCBhN
X-Proofpoint-ORIG-GUID: iKCqYuGESGeFkxRsV4Hz8CLLGsQiCBhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEyNiBTYWx0ZWRfX30Icq0OxCfLi
 OL9yy+jhk9HjPdceMPoXrtGKn/tFvFA9wEbsSNcIwBY/J03T3mFvGEI7OOI12HZVd8++59VBQK7
 E7pzgOjxfj2TBrgVYCLH+xKsJtFnxo32HqjnBP1FBYzqvoFtu0NHC0kSJ30EbwZsl8WCYeQqzN/
 JgaOSHtT4KEsntQ08dM54iEZgNQ7KC7/iESPggH3vZhar0JOizHtoFDysnwrEeXQKwMpbIn7LSN
 RAMCgiQW6x++atL0RHL+231GTpwY2UMLArTjMcNV9rM0bldpHmc4sfkezKOV4gU6j6tDDUslw+i
 +Svp8XTkVQLbTwp1keepQLW6iIqje7Bo/6PaZWi3yal2bDgP4CqYPth7hGsz9eGWfGw7dqhfoY3
 S6uq8ZODMba1FGUtQqCB+PJeoGGP0csC9cFgINc5Rq1wYg3f+kPZjhWXaHcz7o/JkFAm3haJ28G
 bqCi0Jde+ieSV3TgRrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130126
X-Rspamd-Queue-Id: 35B32532CB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10414-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Document the GPI DMA engine on the Eliza SoC.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index fde1df035ad1..d40b0a8dc9e8 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,eliza-gpi-dma
               - qcom,glymur-gpi-dma
               - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260513-eliza-gpi-dma-6b5341271f09

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


