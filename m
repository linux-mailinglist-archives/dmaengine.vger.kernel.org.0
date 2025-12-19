Return-Path: <dmaengine+bounces-7821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0612CCF4DC
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82F3630CAD2A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0F301005;
	Fri, 19 Dec 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owLOZ6PV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PC1VnIu1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A02FBE1D
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138912; cv=none; b=SKxINtXqclMC6NHJYirZlZKi5bFfH4/uJVtXUgiSAIedPZXUggxud/ou+petxxgv92V8a/fVy+WX8KFYkh+LqWZ/nBIO30/LBDab+gHzQn4Sc+zWkne4HYgVrp8dXSlBrrHFzyL+pElhskizazBhzKnFRj2Gphop++INHbDIscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138912; c=relaxed/simple;
	bh=+yW7g724zkTvi6c2Y4D2hyvIoUGp0kLpwcBoXePSCu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rv7+Gyzho7kWngOuaHCDAmd1JsNC7y/2B573DKlHylAbDYFpQELopCJCtN0yWn8SmglNkMQJQnknWoH94h2Fo2xhg6GlTdL94YMB9bzCpnjDa6mFH0iyFzViWwnqL6PKPZ9JDmN4gk4Z0M9CnUa9rfHKPaUzRRdjHKcfJpT+WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owLOZ6PV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PC1VnIu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c68F3999336
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7KsmdZ4x76VsS5fxr1ctBlIdVxj1CBW4LZiVMfMrgUc=; b=owLOZ6PVkqobpWoy
	2YnJ5PHAAAu0NsHXzctawY2nmaC99xDHV3sr82d3vjC9NO7Qa5A+EI7KYeLUp39T
	JDieAYDU4slBSYkp7opowKOKqJBzCOKqZ4x+D3co93m3dfMZwcagjwXVTsKu7tfR
	JyAOShRQjDj2YRUpIMAIsMGc6tLRJq1z95oWKr948+v9DOxyJixkgVMrF6q1Hp/3
	TS4/0eYERadIHWIwSTfPj664yEyvNXLed9kHG2eZZIuYLLtc+crd4vysxiQbylvA
	NXW5j85Cq3pl6DcFx82XH8QiOWg3L/YrnyMd1yotx4EwL1Kq9GfawfYBNdXw+wBp
	n+fCAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r29j9j7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09693109so28682441cf.3
        for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 02:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766138907; x=1766743707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KsmdZ4x76VsS5fxr1ctBlIdVxj1CBW4LZiVMfMrgUc=;
        b=PC1VnIu1n2XD4d8vXJyA1VECFTXywyMW0j7+7AV0A6ToTqNjjURSStOAau3bCF7HZm
         g7kw9Wn1cC+H6vD+YaP7Did3vlX8cSgTJ/Tc8LvoIC41Nw9tav5KEC9xpeRNglDZAqEZ
         NLFj5BX84M1GDSolzXkJGfouit+7AOepNnTahVpIq3l3R+pzPQjWHPwtL71iymuk+/lc
         iHZVbYZnyO0+2QlIA9oLlTQtyaxYXyj1a6nA1Su6/QZDzkWhLlASEoHsUEVNtrXm+F9z
         gIOiJHjGnegn/YTbaRf67pzadBCO8q+RaWP4ObgMhFW0Ldf/ZE+6nEMw4UjL55FBLOyQ
         0Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766138907; x=1766743707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KsmdZ4x76VsS5fxr1ctBlIdVxj1CBW4LZiVMfMrgUc=;
        b=pz9OfLWuZEJa2DI5SkG4V3EcH88RYTcQJ+7LRa1ze/3H2EdTGIsGF/2OgWuJsXfTn/
         tpskUFT/dMUvJ5fP4PDXua+CZ8qkc30qzeQ0tmk3SWZpjyeMVUmWv8HnhP9Ww/T+jU1I
         vs9W/rd+68MwnXNV+zu069yXeb8p3BSlif/thW5wXWZKpIuTPg+cH10U+9/f4RczKmKm
         UOLGuN1GMucTcBAV7JmYRaX8cGdeHVJiQjXFsYmV2+hXcU70es89IqCeoQ28o1ic2WGY
         0cVQCAeB6a/PFB8PpRLSRvsTD8I7JEVJBs0PfBhihe7iQhK2TKegCk516ZwYyiZjz/AX
         o3fA==
X-Gm-Message-State: AOJu0YxHPZwgqqV8YV0dq/cwGhN1QERV2wAUyZqm/lG2FoepYEKOCHNj
	Ug2twy9Dg+/fqlbdY35hBJhPGW02hClotgdhC7ljdqcLySeYxUarAUXm4YEnn5cv9xN7Gx57n0F
	k47b7k4Zn7b++LKUmolfcEPyiEZVLV3uPTyq1mY/BvACwxefqEEcKi5cj9J9d/nw=
X-Gm-Gg: AY/fxX4LhhU/bMF/j5pl7pc0YaA8Nwsw1tBfgeFEookm50Ep1zPTPcfiK+FK0xkQ03o
	pGz31kVHanpQJ4djSTtkv3yy+Qfq6NaIPDI/JmFHIWLrWIJsXJlhaOIZ5wg1/CIBFlpJOYuRPuP
	/GYGhBgkmazL+mK5E/PxBBcoskZpXAtBP2CAiNJZ8/sZY7QdUxDqWkwT6U7kvhG4ljdgHjnA6EO
	w835FrOvvSV5tRsaQZDUqeOU7nFDxEkMbVz7DCpxL90VnIOJWQHs2w/wnE2y1iO3onIrIGMLJxn
	C2omWKrvrsn29VZtP1Ob6Rb+3pAl0gf0wKtX5aygUBmfxAUtuGGFr8fdqO4XaEmrJLzbPVVZMcW
	zgRh3E2Brv0gdalldC61hYDiWD6lWKkwkV1CGJA==
X-Received: by 2002:ac8:5dcb:0:b0:4f1:b9c7:18e7 with SMTP id d75a77b69052e-4f4abccf5c6mr34585751cf.4.1766138907185;
        Fri, 19 Dec 2025 02:08:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVRhXji1ckLD/m55ts+YyuKwNuhTK57fef/BjMCO+TpK2cXQDnhsPIAXLhF6EwDS4P7T8fHw==
X-Received: by 2002:ac8:5dcb:0:b0:4f1:b9c7:18e7 with SMTP id d75a77b69052e-4f4abccf5c6mr34585431cf.4.1766138906730;
        Fri, 19 Dec 2025 02:08:26 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:a48:678b:dad2:b2eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm4209571f8f.27.2025.12.19.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:08:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:07:40 +0100
Subject: [PATCH v10 01/12] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-qcom-qce-cmd-descr-v10-1-ff7e4bf7dad4@oss.qualcomm.com>
References: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
In-Reply-To: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+yW7g724zkTvi6c2Y4D2hyvIoUGp0kLpwcBoXePSCu4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpRSQNfXlXxoKASScjNexD0hZ6xbMQ4AugwhXcJ
 QtIJsvcd2eJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaUUkDQAKCRAFnS7L/zaE
 w4nmD/wMOcgJ12ky6dBNZro/3cEdNyVhXZMXROTbJhW5DdAI9vURbsijk+VvT7ztuHXv22Cyn/c
 sZzVeFB8oEPldbm+ZdgeLteCQohv5oUUUntYsOs/J91F3JoeWnl4YdHLo5cajw4RVcWOduQR0F7
 LLm0E6kfE35ed/hIpHIy60TDduWQqvpyU7J40R7VHVm6o2nFPqycgXyo0qOwk6jp5bQD7uW9vV1
 NXbLKCvriJ3PPHRolnomJ6WArmekBtYZmQknlN0IhmOcoDkHlHKi4IBB8SvBL0vEYgeQVhvQfH5
 vIocD81ia6ZyZdTcDXm5eziqMLcWS6brIjc4i1IBd4MVQsSIstmBvQrvhPRwh8Okj27gjbd8525
 uHDLNmoYUkMKpWsUvd93tPcoyz7ksGR75zDIUWsidziGi2Vd3EdIDhZLItlq0SJD4pNIbaMr6oI
 oN7h/B5/RRNSzQxtQx0pLzwq+iKUmQXdiVerrWRx/kZByJZKV0iFrqQ+CVtmD2F/O5FSonQkDKH
 B8ftFXwsko9xknwKX1F9cpQ+tAu42wIUOccTXq/z2n9bAPJ5HjuS6fleF1BI0gF6tXPg9s1TZ3D
 eW0wgb63pVTkHRsCUS80tKAHB50GqUyI8eiPkL5FB3/HqMWJBOoeNG3NEhHgUafYWqIcQV6Rtl/
 rwSQiRrbvpiLrSA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=P6c3RyAu c=1 sm=1 tr=0 ts=6945241c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: -iR_KNq50knJlaUcdDZrjmSqIlrmaPg9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfXzkuk4LSlsYWx
 KYpV5ulVMb7KlEtdl/CjK483W2T04Ta0ntEC9JJKyHHhTAWjgBgdPVqaP8LfWCwCq44CyXaCuOP
 e9kJTp77bhrgcyBbCm8+LOkXrfKJu/44G3u6tGKT0F8GF/aOlj1ppqp8lDtodlyKvKShWHWf/U3
 plnUAXwkY/HNRE9lGYxCNFCwysnR1Jbde15WVVwmqRjlLTcAlskZEDvJXDHjVQVasvTj7cRfREq
 HsCWbBMjuwYehLx+9FVfCcX539wvY1rlUZKNsg+Hoig6QNxvsKzqgvdAl6q+pWGQeqLSAFkyMib
 XAEjchdTV0wX7L+7fiMxk44kK06P6pH8e+B0ErMXZ5yD/vB8WONnE1F8jNy+d7sGJ6XO7Sr21H5
 FVThM1Ov13hWae5sbavt14KKntayfRO6Lw+rthanqnrzzyhnTl5pvMHbCGKOY56y7+JtpGhO36S
 GJen1zdkqvxI6Z1hvcQ==
X-Proofpoint-GUID: -iR_KNq50knJlaUcdDZrjmSqIlrmaPg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190083

There's no reason for the instances of this struct to be modifiable.
Constify the pointer in struct dma_async_tx_descriptor and all drivers
currently using it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/ti/k3-udma.c        | 2 +-
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 include/linux/dmaengine.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f6eee334f4506a592e72600ae9834..75c8eed063af8daf68cd68670abba211740dd11e 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
 	return 0;
 }
 
-static struct dma_descriptor_metadata_ops metadata_ops = {
+static const struct dma_descriptor_metadata_ops metadata_ops = {
 	.attach = udma_attach_metadata,
 	.get_ptr = udma_get_metadata_ptr,
 	.set_len = udma_set_metadata_len,
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index fabff602065f6cba23cff7bb4f305a3504230a02..e2a40e8dd4b20379f337c1017f8accebeb914645 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -652,7 +652,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 	return seg->hw.app;
 }
 
-static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
+static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
 	.get_ptr = xilinx_dma_get_metadata_ptr,
 };
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..92566c4c100e98f48750de21249ae3b5de06c763 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -623,7 +623,7 @@ struct dma_async_tx_descriptor {
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
 	enum dma_desc_metadata_mode desc_metadata_mode;
-	struct dma_descriptor_metadata_ops *metadata_ops;
+	const struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;

-- 
2.47.3


