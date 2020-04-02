Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB65F19C752
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbgDBQqt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 12:46:49 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:36200 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387891AbgDBQqt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 12:46:49 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032Gd17I026475;
        Thu, 2 Apr 2020 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=n/6lRqGgPE93mT+CUyxc8b2Txw4Zykua2kTbcDoR1uo=;
 b=MN8Uki2w4gO8B+6BNow5ENjlaNBAIhvAhNbRhLbSMpAgNjIduHru+G9txqYDNORBUCsN
 eG+uxAmp3zgaIo7h1knAv5Hkc9+kR1n6Riv42L54iAD1lh7s6YIU3PKcqySQNWMy7MJN
 4PFLrLVX4NW6uOiTkl4L1Bzle8YIIPBlsPIaEuj+BLNl26paiHcp0JvTgwK6JhNLgVmt
 9xCo1lTr35fmsAbMd9kA7fEHGBG6NjZcuHQ5vJyhKgIqjWWUNCszqV2PqkswNxrdsi33
 L/GtDRsYkyYWFclcw5qZh/qoNP6M/mD7m/0xozueZR6dfpYSgP3LLZF0sJrZXetOXAmP qw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 3021n5nbp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 12:46:31 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032GMlb4163124;
        Thu, 2 Apr 2020 12:46:30 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0b-00154901.pphosted.com with ESMTP id 3023cjv538-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 12:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkUnIrm5QmZ6drC2FcFA9kiB7jCnsDrQxCKPC+/+cD5zizxXLH6Gqy1pBtAkdcuQTtfinSAvYXpE00iXiievQ86OnL3osk6WBx7LNrzNhWdHoftleD43/s0aVFSWdPsnWZ0mKHU/LN+yw6NzKBMn07IAZe3WGiKMCUVDAk8NRRbvc+g6lRHCoTuqjf9zEzE75Ek2kYGDBmapoYiJjcaCGarSwl/XaKihQotSpPjI4f7Qn07ilGo0R8VJuN+AW2OIiVjyo9N1UPLqgnMEcAY4B5Pc6tA37jr3+PNgPHQgBd7MSPGpALl2qoUs/mEpAM7LQ+Su5PKdIK7dzXdFC+iijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/6lRqGgPE93mT+CUyxc8b2Txw4Zykua2kTbcDoR1uo=;
 b=Yshge1rX/Qm99fFEHkJFERkzMfCyGwx6Z4QbHgk6ef2zAauuAeBeuRTaE6p6/8l+9eU6Ga6Ks7D+SLrhaPn6/Rd8O3lhs1jz5fPYfTSj4XTxGZMc2K0geh8nm4zV10KUgmnWyJI9R+vOL2LVfD2W6zfaEQTEd6QfNbOBTq9v3VpQn/Q0YpxAZVx+gRYwSsl2wtSd7q0PSSeLb2Xa62Eg6AJP5LTCEOK4k8aSxLZMt9mQz/N158LUfHPaKfX6rKgMigzhHkmoR8p6FvXrVU04JHLOArNgoCI+S9/tKLsaEHCmXsNA8GFCoQfQW9z6U8d7tEKX6qC9OqrC8Keq6aPv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/6lRqGgPE93mT+CUyxc8b2Txw4Zykua2kTbcDoR1uo=;
 b=WJfmngbbtTF37io74jwII0Dz9gQv21yEmDUnV1tIOLru+M6U4gJFCLW5OHjRciLv0YAyHsCwm3H8Q792bIDQVlqUnblSQ2OrwZVn5y8vQfIbKFadbLtNdR+PZ53FxSTl2L6W7JEyinu0cabeoo7cDZCTwfz3SlrTn16IfdLkuvQ=
Received: from DM6PR19MB2682.namprd19.prod.outlook.com (2603:10b6:5:139::14)
 by DM6PR19MB2924.namprd19.prod.outlook.com (2603:10b6:5:13b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 16:46:27 +0000
Received: from DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5]) by DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5%5]) with mapi id 15.20.2878.017; Thu, 2 Apr 2020
 16:46:27 +0000
From:   "Ravich, Leonid" <Leonid.Ravich@dell.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "lravich@gmail.com" <lravich@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        "Barabash, Alexander" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
Thread-Topic: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
Thread-Index: AQHWCQyoCt11n5PvX0iMogpYJAcUmqhmCU6AgAAASmA=
Date:   Thu, 2 Apr 2020 16:46:27 +0000
Message-ID: <DM6PR19MB26827AA2885E8240370A4B1098C60@DM6PR19MB2682.namprd19.prod.outlook.com>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
 <20200402163356.9029-1-leonid.ravich@dell.com>
 <accfd50c-cf70-1145-6776-e4030e7c37fc@intel.com>
In-Reply-To: <accfd50c-cf70-1145-6776-e4030e7c37fc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Leonid.Ravich@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-04-02T16:46:24.1870004Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d8098c11-bfeb-45a1-9e04-d6d5f6222338;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17c8c663-ab29-48de-5789-08d7d7256352
x-ms-traffictypediagnostic: DM6PR19MB2924:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB29246731F1AD3C107A1D391F98C60@DM6PR19MB2924.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2682.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(316002)(4326008)(71200400001)(186003)(8676002)(26005)(478600001)(8936002)(81156014)(33656002)(81166006)(7416002)(66476007)(6506007)(53546011)(66946007)(2906002)(9686003)(55016002)(54906003)(7696005)(86362001)(66446008)(76116006)(110136005)(64756008)(52536014)(786003)(5660300002)(66556008)(309714004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8d0rdN/Dioxz7cDK/Lj+vgxxkvaNdysdkeEt0l+nYXj6cT82N3e+U1RLsGjG+CZxKeqGkipbTdK8KqlUoad1AC1qr0oPXN1V/vkVjoGy8kTz971KClal3vFWF5ssnIrOPRpujfAhNauwpd9eNYeE3p5bDyuE3HUywgsRihFBBR2PJrIK48RCwuw3UjLybBtnTonfzaejRqiDbzpOZN/CZR5Trsvd6jMj3jkLQV8c5LY5Ahoosv1oRUqneNYL76vw/g0uxPde42IxBIcwz0jKNH5bd1CBvLYHCXVMfM9OYgbPeGAJI1A8HBQg8sEaZ/Bmn48OSq4YeNwwJvqMpnvncAadecPaSXqCAKPimfjWYcOPl2EEtyWIw8lca5ESuqp3lMx2fvGE1L/gLMIpik5gklfav/NA6lQVmi3SFlhQVnp2cSXaz8hTCDm5VLrwttSRtlv1ql5Usi/ggb0Z9izfHORlRZY6coCzQs3IKcO3SEIyrZQJA0cuIwyfQUblLcZb
x-ms-exchange-antispam-messagedata: u+J77TjbZ61u8Z7IVP2HIXe8YULGJXWKH8i4lN3GiwBRGPLBXxQjz3M5xrQE09UL0zgbH1PikYkTd9f5LZQ3SFX7m+C1tdQB0wp3j6/u1R7Ngh00bt3aZFreTd8HU9HOSmbQDlLPkY+eAuVk3b91SA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c8c663-ab29-48de-5789-08d7d7256352
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 16:46:27.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdyR6Q3DG3z3jI0IqxgPvjLbtx2Typ/hwHSfI5Bnyz+qmBI1SZtlcPqXpJlzzzOuqsO3kZHhVF8N764Z0udsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2924
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_06:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

U29ycnkgRGF2ZSAsIA0Kc3VyZSB3YXMgdGVzdGVkIG9uIEludGVsIFNreSBMYWtlLUUgQ0JETUEg
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmpp
YW5nQGludGVsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMiwgMjAyMCA3OjQzIFBNDQpU
bzogUmF2aWNoLCBMZW9uaWQ7IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBscmF2aWNo
QGdtYWlsLmNvbTsgVmlub2QgS291bDsgV2lsbGlhbXMsIERhbiBKOyBHcmVnIEtyb2FoLUhhcnRt
YW47IFphdnJhcywgQWxleGlvczsgQmFyYWJhc2gsIEFsZXhhbmRlcjsgVGhvbWFzIEdsZWl4bmVy
OyBLYXRlIFN0ZXdhcnQ7IEppbGF5bmUgTG92ZWpveTsgTG9nYW4gR3VudGhvcnBlOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZG1hZW5n
aW5lOiBpb2F0OiBmaXhpbmcgY2h1bmsgc2l6aW5nIG1hY3JvcyBkZXBlbmRlbmN5DQoNCg0KW0VY
VEVSTkFMIEVNQUlMXSANCg0KDQoNCk9uIDQvMi8yMDIwIDk6MzMgQU0sIGxlb25pZC5yYXZpY2hA
ZGVsbC5jb20gd3JvdGU6DQo+IEZyb206IExlb25pZCBSYXZpY2ggPExlb25pZC5SYXZpY2hAZW1j
LmNvbT4NCj4gDQo+IHByZXBhcmUgZm9yIGNoYW5naW5nIGFsbG9jIHNpemUuDQo+IA0KPiBBY2tl
ZC1ieTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IExlb25pZCBSYXZpY2ggPExlb25pZC5SYXZpY2hAZW1jLmNvbT4NCg0KSGkgTGVvbmlkLCBJIGhh
dmVuJ3QgYWN0dWFsbHkgYWNrZWQgdGhpcyBwYXRjaCB5ZXQsIHBlbmRpbmcgeW91ciBhbnN3ZXIg
b24gaWYgdGhpcyBoYXMgYmVlbiB0ZXN0ZWQgb24gaGFyZHdhcmUuIFRoYW5rcy4NCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2RtYS9pb2F0L2RtYS5jICB8IDE0ICsrKysrKysrLS0tLS0tDQo+ICAgZHJp
dmVycy9kbWEvaW9hdC9kbWEuaCAgfCAxMCArKysrKystLS0tDQo+ICAgZHJpdmVycy9kbWEvaW9h
dC9pbml0LmMgfCAgMiArLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW9hdC9kbWEu
YyBiL2RyaXZlcnMvZG1hL2lvYXQvZG1hLmMgaW5kZXggDQo+IDE4YzAxMWUuLjFlMGU2YzEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2lvYXQvZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEv
aW9hdC9kbWEuYw0KPiBAQCAtMzMyLDggKzMzMiw4IEBAIHN0YXRpYyBkbWFfY29va2llX3QgaW9h
dF90eF9zdWJtaXRfdW5sb2NrKHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAqdHgpDQo+
ICAgCXU4ICpwb3M7DQo+ICAgCW9mZl90IG9mZnM7DQo+ICAgDQo+IC0JY2h1bmsgPSBpZHggLyBJ
T0FUX0RFU0NTX1BFUl8yTTsNCj4gLQlpZHggJj0gKElPQVRfREVTQ1NfUEVSXzJNIC0gMSk7DQo+
ICsJY2h1bmsgPSBpZHggLyBJT0FUX0RFU0NTX1BFUl9DSFVOSzsNCj4gKwlpZHggJj0gKElPQVRf
REVTQ1NfUEVSX0NIVU5LIC0gMSk7DQo+ICAgCW9mZnMgPSBpZHggKiBJT0FUX0RFU0NfU1o7DQo+
ICAgCXBvcyA9ICh1OCAqKWlvYXRfY2hhbi0+ZGVzY3NbY2h1bmtdLnZpcnQgKyBvZmZzOw0KPiAg
IAlwaHlzID0gaW9hdF9jaGFuLT5kZXNjc1tjaHVua10uaHcgKyBvZmZzOyBAQCAtMzcwLDcgKzM3
MCw4IEBAIA0KPiBzdHJ1Y3QgaW9hdF9yaW5nX2VudCAqKg0KPiAgIAlpZiAoIXJpbmcpDQo+ICAg
CQlyZXR1cm4gTlVMTDsNCj4gICANCj4gLQlpb2F0X2NoYW4tPmRlc2NfY2h1bmtzID0gY2h1bmtz
ID0gKHRvdGFsX2Rlc2NzICogSU9BVF9ERVNDX1NaKSAvIFNaXzJNOw0KPiArCWNodW5rcyA9ICh0
b3RhbF9kZXNjcyAqIElPQVRfREVTQ19TWikgLyBJT0FUX0NIVU5LX1NJWkU7DQo+ICsJaW9hdF9j
aGFuLT5kZXNjX2NodW5rcyA9IGNodW5rczsNCj4gICANCj4gICAJZm9yIChpID0gMDsgaSA8IGNo
dW5rczsgaSsrKSB7DQo+ICAgCQlzdHJ1Y3QgaW9hdF9kZXNjcyAqZGVzY3MgPSAmaW9hdF9jaGFu
LT5kZXNjc1tpXTsgQEAgLTM4Miw4ICszODMsOSANCj4gQEAgc3RydWN0IGlvYXRfcmluZ19lbnQg
KioNCj4gICANCj4gICAJCQlmb3IgKGlkeCA9IDA7IGlkeCA8IGk7IGlkeCsrKSB7DQo+ICAgCQkJ
CWRlc2NzID0gJmlvYXRfY2hhbi0+ZGVzY3NbaWR4XTsNCj4gLQkJCQlkbWFfZnJlZV9jb2hlcmVu
dCh0b19kZXYoaW9hdF9jaGFuKSwgU1pfMk0sDQo+IC0JCQkJCQkgIGRlc2NzLT52aXJ0LCBkZXNj
cy0+aHcpOw0KPiArCQkJCWRtYV9mcmVlX2NvaGVyZW50KHRvX2Rldihpb2F0X2NoYW4pLA0KPiAr
CQkJCQkJSU9BVF9DSFVOS19TSVpFLA0KPiArCQkJCQkJZGVzY3MtPnZpcnQsIGRlc2NzLT5odyk7
DQo+ICAgCQkJCWRlc2NzLT52aXJ0ID0gTlVMTDsNCj4gICAJCQkJZGVzY3MtPmh3ID0gMDsNCj4g
ICAJCQl9DQo+IEBAIC00MDQsNyArNDA2LDcgQEAgc3RydWN0IGlvYXRfcmluZ19lbnQgKioNCj4g
ICANCj4gICAJCQlmb3IgKGlkeCA9IDA7IGlkeCA8IGlvYXRfY2hhbi0+ZGVzY19jaHVua3M7IGlk
eCsrKSB7DQo+ICAgCQkJCWRtYV9mcmVlX2NvaGVyZW50KHRvX2Rldihpb2F0X2NoYW4pLA0KPiAt
CQkJCQkJICBTWl8yTSwNCj4gKwkJCQkJCSAgSU9BVF9DSFVOS19TSVpFLA0KPiAgIAkJCQkJCSAg
aW9hdF9jaGFuLT5kZXNjc1tpZHhdLnZpcnQsDQo+ICAgCQkJCQkJICBpb2F0X2NoYW4tPmRlc2Nz
W2lkeF0uaHcpOw0KPiAgIAkJCQlpb2F0X2NoYW4tPmRlc2NzW2lkeF0udmlydCA9IE5VTEw7IGRp
ZmYgLS1naXQgDQo+IGEvZHJpdmVycy9kbWEvaW9hdC9kbWEuaCBiL2RyaXZlcnMvZG1hL2lvYXQv
ZG1hLmggaW5kZXggDQo+IGI4ZThlMGIuLjUyMTZjNmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
ZG1hL2lvYXQvZG1hLmgNCj4gKysrIGIvZHJpdmVycy9kbWEvaW9hdC9kbWEuaA0KPiBAQCAtODEs
NiArODEsMTEgQEAgc3RydWN0IGlvYXRkbWFfZGV2aWNlIHsNCj4gICAJdTMyIG1zaXhwYmE7DQo+
ICAgfTsNCj4gICANCj4gKyNkZWZpbmUgSU9BVF9NQVhfT1JERVIgMTYNCj4gKyNkZWZpbmUgSU9B
VF9NQVhfREVTQ1MgKDEgPDwgSU9BVF9NQVhfT1JERVIpICNkZWZpbmUgSU9BVF9DSFVOS19TSVpF
IA0KPiArKFNaXzJNKSAjZGVmaW5lIElPQVRfREVTQ1NfUEVSX0NIVU5LIChJT0FUX0NIVU5LX1NJ
WkUgLyBJT0FUX0RFU0NfU1opDQo+ICsNCj4gICBzdHJ1Y3QgaW9hdF9kZXNjcyB7DQo+ICAgCXZv
aWQgKnZpcnQ7DQo+ICAgCWRtYV9hZGRyX3QgaHc7DQo+IEBAIC0xMjgsNyArMTMzLDcgQEAgc3Ry
dWN0IGlvYXRkbWFfY2hhbiB7DQo+ICAgCXUxNiBwcm9kdWNlOw0KPiAgIAlzdHJ1Y3QgaW9hdF9y
aW5nX2VudCAqKnJpbmc7DQo+ICAgCXNwaW5sb2NrX3QgcHJlcF9sb2NrOw0KPiAtCXN0cnVjdCBp
b2F0X2Rlc2NzIGRlc2NzWzJdOw0KPiArCXN0cnVjdCBpb2F0X2Rlc2NzIGRlc2NzW0lPQVRfTUFY
X0RFU0NTIC8gSU9BVF9ERVNDU19QRVJfQ0hVTktdOw0KPiAgIAlpbnQgZGVzY19jaHVua3M7DQo+
ICAgCWludCBpbnRyX2NvYWxlc2NlOw0KPiAgIAlpbnQgcHJldl9pbnRyX2NvYWxlc2NlOw0KPiBA
QCAtMzAxLDkgKzMwNiw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19pb2F0X2J1Zyh1bnNpZ25l
ZCBsb25nIGVycikNCj4gICAJcmV0dXJuICEhZXJyOw0KPiAgIH0NCj4gICANCj4gLSNkZWZpbmUg
SU9BVF9NQVhfT1JERVIgMTYNCj4gLSNkZWZpbmUgSU9BVF9NQVhfREVTQ1MgNjU1MzYNCj4gLSNk
ZWZpbmUgSU9BVF9ERVNDU19QRVJfMk0gMzI3NjgNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHUz
MiBpb2F0X3Jpbmdfc2l6ZShzdHJ1Y3QgaW9hdGRtYV9jaGFuICppb2F0X2NoYW4pDQo+ICAgew0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW9hdC9pbml0LmMgYi9kcml2ZXJzL2RtYS9pb2F0
L2luaXQuYyBpbmRleCANCj4gNjBlOWFmYi4uNThkMTM1NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9kbWEvaW9hdC9pbml0LmMNCj4gKysrIGIvZHJpdmVycy9kbWEvaW9hdC9pbml0LmMNCj4gQEAg
LTY1MSw3ICs2NTEsNyBAQCBzdGF0aWMgdm9pZCBpb2F0X2ZyZWVfY2hhbl9yZXNvdXJjZXMoc3Ry
dWN0IGRtYV9jaGFuICpjKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBpb2F0
X2NoYW4tPmRlc2NfY2h1bmtzOyBpKyspIHsNCj4gLQkJZG1hX2ZyZWVfY29oZXJlbnQodG9fZGV2
KGlvYXRfY2hhbiksIFNaXzJNLA0KPiArCQlkbWFfZnJlZV9jb2hlcmVudCh0b19kZXYoaW9hdF9j
aGFuKSwgSU9BVF9DSFVOS19TSVpFLA0KPiAgIAkJCQkgIGlvYXRfY2hhbi0+ZGVzY3NbaV0udmly
dCwNCj4gICAJCQkJICBpb2F0X2NoYW4tPmRlc2NzW2ldLmh3KTsNCj4gICAJCWlvYXRfY2hhbi0+
ZGVzY3NbaV0udmlydCA9IE5VTEw7DQo+IA0K
