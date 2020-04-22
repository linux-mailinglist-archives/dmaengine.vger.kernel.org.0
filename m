Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3721B4AD4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDVQrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 12:47:09 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:18678 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726732AbgDVQrI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 12:47:08 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MGib2b022060;
        Wed, 22 Apr 2020 12:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8sAwbGtPY6C5C2oCLjUhBeRwqaYHoWlxX2hC3iKgaRU=;
 b=vW1wqvVma4wD9UUyBB5HViamUDwpiIJJnIb/JnzYB4KJ55UMkG6t1oR3/pgaskXOYve3
 TP10vaHGVIoPxK5vRkytoot5lCpEyBakrWfnDrCVIoQ9LKCCkKrZGNXYCJv0soLdKaIK
 O9GgTrMGDRVKSnwNhkN4yPjfft6tZkl0QmpA36kBM8JHiBilDo5LRp9LdofXHB0T4Hej
 k8MDlifjPqWzvsrdS60TegIfykpjXjSjbm6tKPjw35HZyWqzCy0j6dvtmIIX/JQClfNf
 hFxgRPUUpyl6ua+x2Bu5jjJZJNxuaDgyJ4nGdgSZHYRlGbGC9OakXfCXYvY5SG/o4RhI /w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30fwcxfsc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 12:46:54 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MGksGA020621;
        Wed, 22 Apr 2020 12:46:54 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-00154901.pphosted.com with ESMTP id 30jr8ra3jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 12:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfueYS+9xkseXXxvKAAc6aR33ocHQi4Si5lZJJM7keVumQVA4APDOvnFp1ReB8odEa9LKjado7uazy9Q2U0YPYuZXnumgxlpmCPugyhKxBLlXz62ejmVQ8QKy0ASUcG7e1vRV/l1fuCCzsqvyDeH9DgOo3NDUYAcLqg2pmfsTmzKHTbEfqJvstM7mMVL7Rvt0+13kORVNA1tm5MQdbpcs5EVJwPJzJ/slKguG9NQWLCWzZURV2PFM3XYZ8zPrhKB/z9RdIa9eHqGhp2v2pEHegyHWEfBNQriLbuFKbKy2k1k/t1ZejHXoCQ3vHMRDQTpucpc85CzM+oXPHumrhRpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sAwbGtPY6C5C2oCLjUhBeRwqaYHoWlxX2hC3iKgaRU=;
 b=oTV4j3QbtgZLvEtB84of5PCk8U8GhbKpVRZByHO9kC64IDi3B0k1Fg4gokPHHzLNRKlMzmOes2GLaW8JMo7mKtx90MAzW5kHcsZJuyRtzu+3mfcv5doczq0UvBPAfQgzgMhYzauwfbkRIpqvSmB3TapgEMgML2AzTPT7uM28LiA0OY1WokYTp9xoXeVAfZd+cjS4+3YYw3Afd4w4Q+Onc2jNiNUb5Y9lL9RmkHNG0pGJa3Hu56pqJWcFo4YKeMCX98AFA7AeP5Papc4ytDqRpAlAhpkNyW2bQo0Emsb2RZoLFab6WzPaoAuor7OYZ0JPRArD0IVQnPcqERWo6F+frQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sAwbGtPY6C5C2oCLjUhBeRwqaYHoWlxX2hC3iKgaRU=;
 b=asxQMLFwcbL2FHXNRP5UZSA5rp42xwM+LUsBgSo8k9m+bmjgKNpJwj/kEVQ05a5RpsLbpK9YTePE+HVR3laGXZ/adRPSobXyWYUnXS6FMI1R2c/wPXadOQ+7oOLMu6anwnUx7VvrC1lXk60QMAl5wRjh+G4/UmAUarp2JqgP2+k=
Received: from DM6PR19MB2682.namprd19.prod.outlook.com (2603:10b6:5:139::14)
 by DM6PR19MB3289.namprd19.prod.outlook.com (2603:10b6:5:6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27; Wed, 22 Apr 2020 16:45:18 +0000
Received: from DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5]) by DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5%5]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 16:45:18 +0000
From:   "Ravich, Leonid" <Leonid.Ravich@dell.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "lravich@gmail.com" <lravich@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Barabash, Alexander" <Alexander.Barabash@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dmaengine: ioat: adding missed issue_pending to
 timeout handler
Thread-Topic: [PATCH 3/3] dmaengine: ioat: adding missed issue_pending to
 timeout handler
Thread-Index: AQHWGJhg4YA7SFfSVESGZnhyjmveYqiFMVkAgAAn6mA=
Date:   Wed, 22 Apr 2020 16:45:18 +0000
Message-ID: <DM6PR19MB2682454E56C25482B85E82B298D20@DM6PR19MB2682.namprd19.prod.outlook.com>
References: <1587554529-29839-1-git-send-email-leonid.ravich@dell.com>
 <1587554529-29839-3-git-send-email-leonid.ravich@dell.com>
 <68c65d83-58fe-f2cb-d505-9b216caa1f4b@intel.com>
In-Reply-To: <68c65d83-58fe-f2cb-d505-9b216caa1f4b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Leonid.Ravich@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-04-22T16:45:14.8939982Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=67d89b23-e4cc-4d3c-b970-ff8414c31a71;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-originating-ip: [85.250.222.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3192a8ae-f061-4d25-da82-08d7e6dc8a81
x-ms-traffictypediagnostic: DM6PR19MB3289:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB328961C719C8C36CABD5837A98D20@DM6PR19MB3289.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2682.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(53546011)(76116006)(55016002)(478600001)(5660300002)(4326008)(71200400001)(9686003)(6506007)(54906003)(316002)(8676002)(33656002)(2906002)(8936002)(81156014)(26005)(186003)(110136005)(7696005)(66446008)(66476007)(66946007)(52536014)(64756008)(786003)(66556008)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgNmEXQcGzmuDg7m0fkLNCwy3MeoJSQs4T4YR3aO+8ODeMsGOK2/pEpcJqRKEuA3M9E0FMX8y1fOZjrDhDTlxMqW972EHfGBBwcoQlW4MJDD6/fKaRMp0iCvgKx4wY+47lfQadnYlZlSDGin1Thvy+4Qz2F/VB2lWPoWs31ahhvBQnfNnAudu4VCEDr+qWt8wsnLQltKDbOlfS739Z3/KBLaniCpxNnb2NLKstJwb2ksF6VdlTxNP9byOaeYoy4BloFjwA3FHojuBhqVJq4ER2hYWXuquGUeAyeB1ch1Nr3biZ1CMeVgThOrUKF/SIR9gZvwL2lCh4xhIrQlm+CMkIRrP+oDD8fTltMGc2AGAwBQdRX71QG7WywFo3miJNLYmSzsoLCHf5A17fukmqOF8cZYH6dMVLcyouFXb3XHcmXAKeMScZ8jvZ1OBmQ6OHBE
x-ms-exchange-antispam-messagedata: kTHwpPJ+60ud5qEM7cfBGnly4N8no58vg2lMD86wAOfJEdaSb41jX5rLENqnn0piB811I/RFWv8KflZmZdFt95CLaIKon0/ACyzb4dJc0UatRVgKqeHIWTFJSohbqopWEJRjYLZGxolxK3TPsfqQfA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3192a8ae-f061-4d25-da82-08d7e6dc8a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 16:45:18.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zu0O6ddRlb0KqmJDqp6o82bZ4XU+khPDzKumpTlc5fZ6LX+8qh4/Ls8yWwDPAIrVf30phhy2n8CFZnlxUYoz2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3289
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_06:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220125
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220125
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gDQo+IE9uIDQvMjIv
MjAyMCA0OjIyIEFNLCBsZW9uaWQucmF2aWNoQGRlbGwuY29tIHdyb3RlOg0KPiA+IEZyb206IExl
b25pZCBSYXZpY2ggPExlb25pZC5SYXZpY2hAZW1jLmNvbT4NCj4gPg0KPiA+IGNvbXBsZXRpb24g
dGltZW91dCBtaWdodCB0cmlnZ2VyIHVubmVzZXNlcnkgRE1BIGVuZ2luZSBodyByZWJvb3QgaW4N
Cj4gPiBjYXNlIG9mIG1pc3NlZCBpc3N1ZV9wZW5kaW5nKCkgLg0KPiANCj4gSnVzdCBjdXJpb3Vz
LCBhcmUgeW91IGhpdHRpbmcgYSB1c2UgY2FzZSB3aGVyZSB0aGlzIGlzIGhhcHBlbmluZz8gQW5k
IHdoYXQncw0KPiBjYXVzaW5nIHRoZSBjb21wbGV0aW9uIHRpbWVvdXQ/DQoNClVuZm9ydHVuYXRl
bHkgSSBkaWQgICwNCmluIG15IGNhc2UgSSBtaXNzZWQgY2FsbGluZyAgZG1hX2FzeW5jX2lzc3Vl
X3BlbmRpbmcoKSBhZnRlciBmZXcgZG1hZW5naW5lX3ByZXBfZG1hX21lbWNweSgpIGR1ZSB0byBz
b21lIGVycm9yIGhhbmRsaW5nIGJ1ZyAsICB0aW1lb3V0IHRpbWVyICB3ZXJlIHN0aWxsIGFybWVk
IGR1ZSB0byBwcmV2aW91cyByZXF1ZXN0cyAocHJvYmFibHkpICBhbmQgd2hlbiBmaW5hbGx5IHRo
ZSB0aW1lciBmaXJlZCB0aGUgZW5naW5lIHdlcmUgYWN0aXZlIChpb2F0X3JpbmdfYWN0aXZlKCkp
IHNvIGl0IHdlbnQgdG8gcmVzZXQgLg0KDQpBdCBsZWFzdCB0aGlzIGlzIHRoZSB0aGVvcnkgOiku
DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGVvbmlkIFJhdmljaCA8TGVvbmlkLlJhdmlj
aEBlbWMuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9kbWEvaW9hdC9kbWEuYyB8IDcgKysr
KysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lvYXQvZG1hLmMgYi9kcml2ZXJzL2RtYS9pb2F0L2RtYS5j
IGluZGV4DQo+ID4gNTVhOGNmMS4uMmFiMDdhMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Rt
YS9pb2F0L2RtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvaW9hdC9kbWEuYw0KPiA+IEBAIC05
NTUsNiArOTU1LDEzIEBAIHZvaWQgaW9hdF90aW1lcl9ldmVudChzdHJ1Y3QgdGltZXJfbGlzdCAq
dCkNCj4gPiAgIAkJZ290byB1bmxvY2tfb3V0Ow0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJLyogaGFu
ZGxlIG1pc3NlZCBpc3N1ZSBwZW5kaW5nIGNhc2UgKi8NCj4gPiArCWlmIChpb2F0X3JpbmdfcGVu
ZGluZyhpb2F0X2NoYW4pKSB7DQo+ID4gKwkJc3Bpbl9sb2NrX2JoKCZpb2F0X2NoYW4tPnByZXBf
bG9jayk7DQo+ID4gKwkJX19pb2F0X2lzc3VlX3BlbmRpbmcoaW9hdF9jaGFuKTsNCj4gPiArCQlz
cGluX3VubG9ja19iaCgmaW9hdF9jaGFuLT5wcmVwX2xvY2spOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiAgIAlzZXRfYml0KElPQVRfQ09NUExFVElPTl9BQ0ssICZpb2F0X2NoYW4tPnN0YXRlKTsNCj4g
PiAgIAltb2RfdGltZXIoJmlvYXRfY2hhbi0+dGltZXIsIGppZmZpZXMgKyBDT01QTEVUSU9OX1RJ
TUVPVVQpOw0KPiA+ICAgdW5sb2NrX291dDoNCj4gPg0K
