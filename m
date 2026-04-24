Return-Path: <dmaengine+bounces-10108-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAVQFn1V62nkKwAAu9opvQ
	(envelope-from <dmaengine+bounces-10108-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6AC45DC6B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C323E301CDB6
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97F3BADA0;
	Fri, 24 Apr 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLf7kq0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLFh/UDY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCB3264CC
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030501; cv=none; b=NUlKVIAT3aDsYSN3g0ombORqE3uuXQLy8SzRJDDvXERwIpm0OWfPuffcNevIYuLgpFogD6LQgiwfnP8SqKxs+YdPRXzZ/EmxJ194JcCLR4vrzhpQFElIlx9Yhsa7qRUChnIw9M406XzJwgWr3iFLN6wf1863+oeCxL12nDd0Qmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030501; c=relaxed/simple;
	bh=uRqx9+tFa9YY1/KJ/Gku08nL4dvx/MN+1g5RGjJmq4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQn2v02A+29rUSmjxt0KL8HGaqglFIDDH1b4rbh/+lVooUCC8NHpPkqFjIoPF6CeRlmfo/o53ba3XHRKjpxKcCx2BKyiitN1QK7pQrgbtnWMUDd5ssRgQ+bedUe5W+plHE1jWEWt8gHGOOp3Xjma4x7bXGn64djl3peDUyfDajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLf7kq0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLFh/UDY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O9j3vB756981
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9oSHDQ58vYI36DndD9bBqdtSMKh7IjUIJiykP/8kfoE=; b=FLf7kq0Pes0slB9b
	D9FZCYpkHYLKTiS6JNH1htgwRHkOxhvAPW5eHflvzW5akQoz8Ji+UdXraFIGrIGa
	MnbXw1UpVjXNspp3CPl5Oo5iTvFOZc+lTL+hT/rkz0bHeJ6PbnC7UznWtUj/Uewr
	QfIzGX8/9fGhlpuY8knd8MB0kK9/dPvPOkDO0XrUyos7T17b0/mc/thUL+DjsiZl
	Gio785bjeH77hyZ2A4RLGEzRXU4eObjMSXvv8as7W3f9nE3v9e+G22wvnIUibCNW
	zgltcH5+SPRGhHSZuEhRJQpbI7gUFzte7JiXlaeNS8VIvELBI+vxKDuMc6/7urhm
	QT9T/Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr4bktbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fb6cd0879so7367818a91.2
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777030496; x=1777635296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oSHDQ58vYI36DndD9bBqdtSMKh7IjUIJiykP/8kfoE=;
        b=VLFh/UDY367xT+7XGXiMzQedhq/7i778TyigeNX+kfpupBMCqUgoIoH74bigXbQvCe
         EyZjmw/pCe1JI+LFQsPMapcZpun0P971i0cRgMXg7hzRKjP459ShRwu1+2lNp4uhbYp2
         5ijG/T9tlkR/RjrGGibbDSehXi8l82GY03WV+TImirAE3u6i4MMsPzGyPGTJO+e51BWw
         a0wy860QEKEhMcusu/kekc8AOyGxvo6MkZ7hBxa4cbxYumSwxczi5jMzqxZFusdGrx7q
         Hz12JGhjwn/bXxELLgbgq9snfkhdw/yQIuUZX9rASDMM2yUuXvp6ib6zfXGEfCmA9unD
         VSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030496; x=1777635296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9oSHDQ58vYI36DndD9bBqdtSMKh7IjUIJiykP/8kfoE=;
        b=Qa90PntGLEO+mfFiadJLsOsZGM67FxOJzS22vykkwMIflNEUiKSXOPd9dipDQvbz62
         JicU+LqxxmV8lTvnC66ASkW7fPH1p2NQQLrADHzeTOhsCEqB6FVB9cRq9rN3Wiu4jZ1H
         cGCU67sW7rSfw1EsqlRJizAU8LaUfIRjmPtlS0rU43WkIImvfQeneHap/TzlixgAye7S
         UdpTSmgYTFenGiGPgaQl4ZiTojEilam/O3M1WaqVOo0EL1WAMkDMvZNcAwQzg5cpqa9N
         haOMVanceJ2sWACaS3tGz46uzuy1nfBbu31MhspX/rI4i2fjyGilt7BioyBXEwlCD3is
         ysxw==
X-Forwarded-Encrypted: i=1; AFNElJ+1Wq/L76mDzFXbWsj25m3ISGBPQ0qIsWJLd8mqunlJmCSFSTuuWORaSIt0zaNWD4F9umd5ioco1/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCV2cvgjBzVQU+I4wVDLju1sQg0woCsIl4CRtEpHTj3FBhfxg3
	8rQa4pBh4F8qQptJBQkGLed7GaweUfj97ImqwUEypEkGXvE0LjAeBLzL3GlC8GVBtEQrOVaG8R9
	xuYW2PANglMDlpDptCA+eMpTijRJVk7l7RCdtccFzmngOTctRuld3CeymCez66lg=
X-Gm-Gg: AeBDieu8k5i8d61t+oP8fhmEWiwPspkh0NPfC1rBb1pTJeKaYqEKCf5fUPGVagrMOBs
	MdZRKwkMXNcej4kG2lWqeSiRD+rpjPndGbjiQWMj+0l4nk8GMT8QyCzl6gfc0Oz0vNtN52VmnCD
	rc1zEIa5QhLRTjfUElJsBNCHKadtk/Nq26IfUzLNtimfDrIvl8RvFoNg14XzXiIimZxsYlbfTUl
	Wa9sfLhJvFrwctqFhDVhIZtGJ648l0RlBotQ5IW6Bj1uhcAC4nYXVlPor45uvwXUd7/hp5RLtpj
	brT28k93zao81lIfNC4aqSD/p/LlljTn7GfXmY+WNZSrECkuB6jVADCsQOKztpPerlxVKoGQ3Cx
	GGulLIysAeURQ7qbs5Bvy211O0jQCrLRTp6DOh6WPtZL9Oeydu4xfCW2XSdmm9lwYcw==
X-Received: by 2002:a17:90b:5865:b0:35d:a557:e41 with SMTP id 98e67ed59e1d1-3614046f978mr34671505a91.14.1777030495999;
        Fri, 24 Apr 2026 04:34:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5865:b0:35d:a557:e41 with SMTP id 98e67ed59e1d1-3614046f978mr34671476a91.14.1777030495353;
        Fri, 24 Apr 2026 04:34:55 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm24204734a91.2.2026.04.24.04.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:34:54 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 17:04:15 +0530
Subject: [PATCH 1/3] dt-bindings: dma: qcom: bam-dma: Add support for
 kaanapali BAM v2.0.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-knp_qce-v1-1-813e18f8f355@oss.qualcomm.com>
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
In-Reply-To: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMCBTYWx0ZWRfX+jvV+2uq1isD
 kX/khMomYjTDdFsclTp3y07pSQalbYb3+C8wCTtKj5VOzdImimBdyi5ExQNSB0L7Z0TfOa3qy5t
 tuci38i5NGi8Hwj7JypEp/300VtenDDDcVQTuW1vG8GISWEJ7QKWWg8zMvbcPtWAw+XJeH4o72X
 RTSR7w4yP86FMMpq0DgiQaRjH2NfmxyPw1aBCggOwqmZgM67nYNg8spemfw1LQTykTGlp+/qFsx
 VPXTuxFiCM78KGVg+WsZt7RJxW+GCvd6mzUcdAkmYtZNHrUGcikvUeo8hiVlNJ/HUzmKhA1uszb
 i/mNjk2NKOgok4X5H5TSX1JRvM99wyuYWnbdTL0CC4e4RIzulb8gtg+rh2ZD0E2IrouOYor1igR
 9IzcsU/yGRcGR7LGt0u0NLTNqG1tsd6veDo/Ob5MFEKBCam332YkrJ2kkdc0inmD0AtkZ4Yly2q
 5zZHeJ+xu1WFcx4gmQA==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=69eb5561 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6hn-QP140KOHNlEGON0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ru5XEOxsqTEL9QlKwfU11A32Ahm8jvBg
X-Proofpoint-GUID: ru5XEOxsqTEL9QlKwfU11A32Ahm8jvBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240110
X-Rspamd-Queue-Id: CA6AC45DC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10108-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,1dc4000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Kaanapali support newer BAM v2.0.0 version.
Document the compatible string and update example along with it.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 6493a6968bb4..0923fb189ada 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -23,6 +23,8 @@ properties:
           - qcom,bam-v1.4.0
           # MSM8916, SDM630
           - qcom,bam-v1.7.0
+          # Kaanapali
+          - qcom,bam-v2.0.0
       - items:
           - enum:
               # SDM845, SM6115, SM8150, SM8250 and QCM2290
@@ -118,4 +120,23 @@ examples:
         #dma-cells = <1>;
         qcom,ee = <0>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@1dc4000 {
+            compatible = "qcom,bam-v2.0.0";
+            reg = <0x0 0x01dc4000 0x0 0x22000>;
+            interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+            iommus = <&apps_smmu 0xc0 0>, <&apps_smmu 0xc1 0>;
+            qcom,ee = <0>;
+            qcom,num-ees = <4>;
+            num-channels = <20>;
+            qcom,controlled-remotely;
+        };
+    };
 ...

-- 
2.34.1


