Return-Path: <dmaengine+bounces-6699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126CDB98456
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 07:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819824C2E81
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BC1946DF;
	Wed, 24 Sep 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hMtlyqtv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254863B9;
	Wed, 24 Sep 2025 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691025; cv=none; b=Cf+OExHTR/KbkBwP18OkbzruwQcp4lRGgl/EcZo0j+s0MwqQre/yk8cB1mswNrkcIDIIHoKay7y/Z8UpI0oaQAVfBZ1ilCUvyCdcb6TeKMLjb5nR/aBjc6yqRhrZ6mhA5hma0iscnrVu4c6I6TSjbtcd9xcTSgpbw2RslPiBU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691025; c=relaxed/simple;
	bh=nB1zuqgBIzHTlltWiPwiFuRDfu74YHAK/yEgAiO5UEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7Om+rznpkQ6Rsa96eISSXfcYl8Vs7aJYY+Mzwg/Zf69W1dQO6S74dyPLZ9a1dIPibrDebeHwhYDk8brC9xO6hV9PiPhhtUv/z32IVCT9otkGs36Xjro3TaA6dLb118EPmxYEWajRKRSKMFKgeRX7YUO3Uh8xH5hwqZQjka2qdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hMtlyqtv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iIqB002802;
	Wed, 24 Sep 2025 05:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nB1zuqgBIzHTlltWiPwiFuRDfu74YHAK/yEgAiO5UEk=; b=hMtlyqtvOPhvHwM3
	MtI+aeN0Wn6C/OYB8LtzJ5jCX1FE3UgCbRTY/Q4v2s4dHsIh5m9VMZPuCwvYS24M
	s3+YHkOOFdzahf1+iH7b6YFAzn+WVQEm3hTYAUG1YArpDUdgrxBtGkvgugB2bbBT
	uYVR5+UU7ESV7JLadUyo8BDoysmM0tMXwpAx0AMFw/vvD7Y6TCto/mKG/z+VQFQc
	MSAy/R2USx00+If4FwqtOTrQQB7xaDXPCiw3bfC72b7xWNS+TJewZz0zeZ/kjADj
	GTichiMzlyHcLj2SrlZH8ba2+WuOPtix5ujv3s30rXfKEo1mrq6DGmJxny8DfU0T
	Ns1nLQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajewmhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 05:17:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58O5Gxha030614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 05:16:59 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 22:16:59 -0700
Received: from nalasex01c.na.qualcomm.com ([fe80::fbb2:6e42:b3:9ade]) by
 nalasex01c.na.qualcomm.com ([fe80::fbb2:6e42:b3:9ade%11]) with mapi id
 15.02.1748.024; Tue, 23 Sep 2025 22:16:59 -0700
From: "Lakshmi Sowjanya D (QUIC)" <quic_laksd@quicinc.com>
To: "Md Sadre Alam (QUIC)" <quic_mdalam@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konradybcio@kernel.org"
	<konradybcio@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: "Varadarajan Narayanan (QUIC)" <quic_varada@quicinc.com>
Subject: RE: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
Thread-Topic: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
Thread-Index: AQHcKIBoYleawDnj40GyEsebX5ELobSZMe8AgAFG0ICAB1e6oA==
Date: Wed, 24 Sep 2025 05:16:58 +0000
Message-ID: <f9d84f085abf4feaa4c957ca355b2fac@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
 <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
 <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
In-Reply-To: <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cm6YIFjb8E5ojxUVTy2PctQWUpizo6vN
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d37ecc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=xqWC_Br6kY4A:10 a=WSRc6ELujCsA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Ke_3Dhk9dvTKENNZyrAA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX8M2+v3cjjd/H
 Qiwf9PBS/gN9LZR1HMkSWxS66h9x5UdFB5XSs8QhMjyhJTLqHzV1wTIbfd8HzMnZkrNBVZNB9W2
 jE3YtWmhmAzJwEhq1S4Zv5cwsK8BUTQzw0tSIt7AmxlcblzcQxlVKwultRsuaYyFs0XyPBWoDbY
 endDpkcwLE1jaws8PvRPG+wjAD3Y5zz72hLvzrQ9KOobRkZ+GKd6PAAlTftlbide4r3tVTW01Y3
 4t/JFwRxHsF9tIjEOCOfek2S1hxIo0n3GVelNJjuqwrgQ32D4G823D/r1gBASBJEXvn332ZUZay
 cy9X6/OdkKjCVWwhqIrZ3q9XKKxYlnsCBVvtJyregYPqK9mpYQ/6FFwnLdN43+eNHylNpzSIIDo
 /T5lIRpU
X-Proofpoint-ORIG-GUID: cm6YIFjb8E5ojxUVTy2PctQWUpizo6vN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWQgU2FkcmUgQWxhbSA8
cXVpY19tZGFsYW1AcXVpY2luYy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDE5LCAy
MDI1IDExOjI3IEFNDQo+IFRvOiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHliY2lvQG9zcy5xdWFs
Y29tbS5jb20+Ow0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytk
dEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBhbmRlcnNzb25Aa2VybmVsLm9y
Zzsga29ucmFkeWJjaW9Aa2VybmVsLm9yZzsNCj4gdmtvdWxAa2VybmVsLm9yZzsgbGludXgtYXJt
LW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBk
bWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBWYXJhZGFyYWphbiBOYXJheWFuYW4gKFFV
SUMpIDxxdWljX3ZhcmFkYUBxdWljaW5jLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzld
IGRtYTogcWNvbTogYmFtX2RtYTogRml4IGNvbW1hbmQgZWxlbWVudCBtYXNrDQo+IGZpZWxkIGZv
ciBCQU0gdjEuNi4wKw0KPiANCj4gDQo+IA0KPiBPbiA5LzE4LzIwMjUgMzo1NyBQTSwgS29ucmFk
IER5YmNpbyB3cm90ZToNCj4gPiBPbiA5LzE4LzI1IDExOjQwIEFNLCBNZCBTYWRyZSBBbGFtIHdy
b3RlOg0KPiA+PiBCQU0gdmVyc2lvbiAxLjYuMCBhbmQgbGF0ZXIgY2hhbmdlZCB0aGUgYmVoYXZp
b3Igb2YgdGhlIG1hc2sgZmllbGQgaW4NCj4gPj4gY29tbWFuZCBlbGVtZW50cyBmb3IgcmVhZCBv
cGVyYXRpb25zLiBJbiBuZXdlciBCQU0gdmVyc2lvbnMsIHRoZSBtYXNrDQo+ID4+IGZpZWxkIGZv
ciByZWFkIGNvbW1hbmRzIGNvbnRhaW5zIHRoZSB1cHBlciA0IGJpdHMgb2YgdGhlIGRlc3RpbmF0
aW9uDQo+ID4+IGFkZHJlc3MgdG8gc3VwcG9ydCAzNi1iaXQgYWRkcmVzc2luZywgd2hpbGUgZm9y
IHdyaXRlIGNvbW1hbmRzIGl0DQo+ID4+IGNvbnRpbnVlcyB0byBmdW5jdGlvbiBhcyBhIHRyYWRp
dGlvbmFsIHdyaXRlIG1hc2suDQo+ID4NCj4gPiBTbyB0aGUgaGFyZHdhcmUgY2FuIHJlYWQgZnJv
bSBoaWdoZXIgYWRkcmVzc2VzIGJ1dCBub3Qgd3JpdGUgdG8gdGhlbT8NCj4gTm8sDQo+IFdyaXRl
IE9wZXJhdGlvbnM6IENhbiB0YXJnZXQgYW55IDMyLWJpdCBhZGRyZXNzIGluIHRoZSBwZXJpcGhl
cmFsIGFkZHJlc3MNCj4gc3BhY2UgKHVwIHRvIDRHQikNCj4gDQo+IFJlYWQgT3BlcmF0aW9uczog
Q2FuIHJlYWQgZnJvbSBhbnkgMzItYml0IHBlcmlwaGVyYWwgYWRkcmVzcyBhbmQgcGxhY2UgdGhl
DQo+IGRhdGEgaW50byAzNi1iaXQgbWVtb3J5IGFkZHJlc3NlcyAodXAgdG8gNjRHQikgc3RhcnRp
bmcgZnJvbSBCQU0gdjEuNi4wDQo+ID4NCj4gPiBQbHVzLCB5b3UgZGlkbid0IGV4cGxhaW4gd2hh
dCB0aGUgbWFzayByZWdpc3RlciBkb2VzIG9uIEJBTSA8MS42LjAuDQo+ID4gSWYgaXQgcmVhbGx5
IG1hc2tzIHRoZSBhZGRyZXNzLCBhbGwgcmVhZHMgd2lsbCBub3cgcG9pbnQgdG8gMHgwDQo+IFRo
ZSBtYXNrIGZpZWxkIG5ldmVyIG1hc2tzIGFkZHJlc3NlcyBpbiBhbnkgQkFNIHZlcnNpb24uIEhl
cmUncyB0aGUNCj4gY29tcGxldGUgc3BlY2lmaWNhdGlvbjoNCj4gDQo+IEJBTSBDb21tYW5kIEVs
ZW1lbnQgU3RydWN0dXJlDQo+IA0KPiBXcml0ZSBDb21tYW5kIEVsZW1lbnRzIChBbGwgQkFNIFZl
cnNpb25zKToNCj4gDQo+IHwgRmllbGQgIHwgQml0cyAgfCBEZXNjcmlwdGlvbiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8LS0tLS0tLS18LS0tLS0tLXwtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gfCAx
c3QgRFcgfCAzMToyNCB8IENvbW1hbmQgKG11c3QgYmUgMCBmb3Igd3JpdGUpICAgICAgICAgICAg
ICAgICAgICAgICB8DQo+IHwgICAgICAgIHwgMjM6MCAgfCBBZGRyZXNzIC0gdGFyZ2V0IGFkZHJl
c3MgaW4gcGVyaXBoZXJhbCAgICAgICAgICAgICAgfA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gfCAy
bmQgRFcgfCAzMTowICB8IERhdGEgLSB0aGUgZGF0YSB0byBiZSB3cml0dGVuICAgICAgICAgICAg
ICAgICAgICAgICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiB8IDNyZCBEVyB8IDMxOjAgIHwgTWFz
ayAtIDMyLWJpdCBtYXNrIGRlZmluaW5nIHdoaWNoIGJpdHMgdG8gbW9kaWZ5ICAgIHwNCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gfCA0dGggRFcgfCAzMTowICB8IFJlc2VydmVkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4g
UmVhZCBDb21tYW5kIEVsZW1lbnRzIChCQU0gPCB2MS42LjApOg0KPiANCj4gfCBGaWVsZCAgfCBC
aXRzICB8IERlc2NyaXB0aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+IHwtLS0tLS0tLXwtLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiB8IDFzdCBEVyB8IDMxOjI0IHwgQ29tbWFuZCAobXVz
dCBiZSAxIGZvciByZWFkKSAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gfCAgICAgICAgfCAy
MzowICB8IEFkZHJlc3MgLSBzb3VyY2UgYWRkcmVzcyBpbiBwZXJpcGhlcmFsICAgICAgICAgICAg
ICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiB8IDJuZCBEVyB8IDMxOjAgIHwgRGVzdGluYXRpb24g
LSBtZW1vcnkgYWRkcmVzcyB0byB3cml0ZSByZWFkLWRhdGEgICAgIHwNCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IHwgM3JkIERXIHwgMzE6MCAgfCBSZXNlcnZlZCAoSUdOT1JFRCBieSBoYXJkd2FyZSkg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gfCA0dGggRFcgfCAz
MTowICB8IFJlc2VydmVkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gUmVhZCBDb21tYW5kIEVsZW1lbnRzIChCQU0g
Pj0gdjEuNi4wKToNCj4gDQo+IHwgRmllbGQgIHwgQml0cyAgfCBEZXNjcmlwdGlvbiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8LS0tLS0tLS18LS0tLS0tLXwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4g
fCAxc3QgRFcgfCAzMToyNCB8IENvbW1hbmQgKG11c3QgYmUgMSBmb3IgcmVhZCkgICAgICAgICAg
ICAgICAgICAgICAgICB8DQo+IHwgICAgICAgIHwgMjM6MCAgfCBBZGRyZXNzIC0gc291cmNlIGFk
ZHJlc3MgaW4gcGVyaXBoZXJhbCAgICAgICAgICAgICAgfA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
fCAybmQgRFcgfCAzMTowICB8IERlc3RpbmF0aW9uIC0gMzIgTFNCcyBvZiAzNi1iaXQgZGVzdGlu
YXRpb24gYWRkciAgICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiB8IDNyZCBEVyB8IDMxOjQgIHwg
UmVzZXJ2ZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
fCAgICAgICAgfCAzOjAgICB8IERlc3RpbmF0aW9uIEFkZHJlc3MgNCBNU0JzIChiaXRzIDM1OjMy
KSAgICAgICAgICAgICB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiB8IDR0aCBEVyB8IDMxOjAgIHwg
UmVzZXJ2ZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBGb3IgUmVhZCBDb21tYW5kczoNCj4gLSBCQU0gPCB2MS42
LjA6IDNyZCBEd29yZCBjb21wbGV0ZWx5IGlnbm9yZWQgYnkgaGFyZHdhcmUNCj4gLSBCQU0gPj0g
djEuNi4wOiAzcmQgRHdvcmRbMzowXSBjb250YWlucyB1cHBlciA0IGJpdHMgb2YgZGVzdGluYXRp
b24gYWRkcmVzcw0KPiANCj4gVGhhbmtzLA0KPiBBbGFtLg0KDQpUZXN0ZWQtYnk6IExha3NobWkg
U293amFueWEgRCA8cXVpY19sYWtzZEBxdWljaW5jLmNvbT4gICMgb24gU0RYNzUNCg0KVGhhbmtz
LA0KTGFrc2htaSBTb3dqYW55YQ0KDQo=

