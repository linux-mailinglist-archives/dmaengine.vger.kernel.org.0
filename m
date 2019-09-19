Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D156B79F8
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfISNAE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 09:00:04 -0400
Received: from mail-sy3aus01hn2022.outbound.protection.outlook.com ([52.103.199.22]:46432
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387963AbfISNAE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Sep 2019 09:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5rzFITnMWT3EBpePiCp7hD0BJLKKj4ZQrm0IKHcLj6/X26k6jPIoxNaVFDafcEBRSRvJm4iutlA9LsjV7K4F9wCXWvEwnwlHUQN5g2Lb8F+4TQ95bcNMKFN2/Hh0Tj13Vxcw0TtB1XR8Ddf0BKoTYPUwLNtZbOFjzWNqK0jRxE2mc+kQYCvK/oObndl2r7uLsv005ByKWmf1dWCc1v/nsiW79ohdAx8sKJa84itfKjwWqqPddz9u5lYo31vdpWNtzRk1HBKGKzCWuAGbxA2xJiWrmiWmdkYecRBp/rum1SaD/g7mhA4QlJ7irC9f9quTKWrM2JcTawFkI2bzjG82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=dNnNI78M8iVqEOcXMpJQHYpmaIiEEz/08qXVytAELLRWrHuy4v1zRndrWCFF225qyz242sPJQKRrfc3kcOQBnD0niG8acEHkjG1C5hftews8v8Ued26YJa8cPkUtBA/V2NnXCmkNdh1BXGYnnAVAcG7YtKHV0FUrewZSMLdxPuawnyz9ew/6zsNiya/BSFsHeHi/pAnt4wdksF/MjCdiAhLT8TSU+tVR/SjT7GuRx1XSGYteyR2ypjtn/+qUrdH5AR7hmYo3X3ssspnOfV/ySx6faSIeLZ8wI9LAssNttxQvh0So2s/nYiLcboKrKW5PN1A5EEhcL+XpkGstbHA7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=f62ft/btrvPqq4jmx36wVmdTyEF2h/gMa2pJvYOJOHHPI6EVFwmWaefoihU2ypcpT67VxynUVe2ZriHqQx7Za45E0NkyawRuDletrRPJ406fnN/5lpMu+reQHl7wF3SsQkpOWkiMjo65upcTKFi0b/PLq+1bKLxeqwT1EhpwXL4=
Received: from ME2PR01MB3059.ausprd01.prod.outlook.com (52.134.210.142) by
 ME2PR01MB2978.ausprd01.prod.outlook.com (52.134.209.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Thu, 19 Sep 2019 12:59:57 +0000
Received: from ME2PR01MB3059.ausprd01.prod.outlook.com
 ([fe80::cde5:dbfc:c27a:ee04]) by ME2PR01MB3059.ausprd01.prod.outlook.com
 ([fe80::cde5:dbfc:c27a:ee04%4]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 12:59:57 +0000
From:   <13092299@student.uts.edu.au>
To:     Giorgia Rapella <Giorgia.Rapella-1@student.uts.edu.au>
Subject: Darlehensangebot
Thread-Topic: Darlehensangebot
Thread-Index: AQHVbuoj+X7+pEOumU+grnTbOXcoVw==
Date:   Thu, 19 Sep 2019 12:59:57 +0000
Message-ID: <ME2PR01MB30598405FB520053C1D03B73A4890@ME2PR01MB3059.ausprd01.prod.outlook.com>
Reply-To: "chelsealoan4@gmail.com" <chelsealoan4@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To ME2PR01MB3059.ausprd01.prod.outlook.com
 (2603:10c6:201:25::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Giorgia.Rapella-1@student.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [154.160.2.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8a31d0-602a-41cc-5f05-08d73d01461a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:ME2PR01MB2978;
x-ms-traffictypediagnostic: ME2PR01MB2978:
x-microsoft-antispam-prvs: <ME2PR01MB2978B25DDA7F4ACF4D416B7786890@ME2PR01MB2978.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(6506007)(6116002)(3846002)(33656002)(6636002)(786003)(7116003)(256004)(386003)(14444005)(43066004)(71190400001)(2906002)(316002)(6862004)(5003540100004)(52536014)(71200400001)(8796002)(8936002)(66806009)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(2171002)(486006)(8676002)(81156014)(3480700005)(476003)(4744005)(81166006)(66574012)(221733001)(7696005)(66066001)(52116002)(22416003)(9686003)(6436002)(55016002)(99286004)(102836004)(325944009)(2860700004)(74316002)(7736002)(186003)(25786009)(305945005)(88552002)(26005)(14454004)(7416002)(478600001)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:ME2PR01MB2978;H:ME2PR01MB3059.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:de;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: student.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bgmm/L5G6qzO/SpkbP8qxN+GPH3uczgxlGxrigx9UsrkBK1KfXhimItQRGeBetV9n1RLnMYZcljuVCraciSJ2K95XcyHe/EQJKvH3qVwQ8AAqIihL7v42gGzNh2y7Dq3kQF2GYfo8B61frmq0Uxz1lbzPFp0XzGwY81ddFFisL0G7JDKbz1TqZKcP/hBrjArnJei6mDfIGhWdVB8NdmxvgJCuELRig3YqdsiZRHy5VFONYE4ZzgYPUS0VllsMCXuNM+lScPEkodo7f42IBmRK7SoTnfNzlYESW8ypSQll6K16NcA9YDZ8LQsEk7Omr1K/isvJU6t+UyR4LTHfJt8MCXOzFp1G0ZbRSC1jBqTcmzJACB34PDPo+XTBy2l6x9yGlOCUGFwPBffHH0G5/WY3Mwmhwy/RzFpOxncmWWFYzw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2719EDAE2B1F79478C861012B6CA6D27@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8a31d0-602a-41cc-5f05-08d73d01461a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 12:59:57.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqaNQagAK6S2RG0G3G8Ava0NnNG+QaOP3KX89efSMU79I+POsSpqUJ9rrQi7+af9PIHZDpd5o2nOnmp83iaxulx+3VX+N5uziAUZTW9AduU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB2978
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sch=F6nen Tag

Ben=F6tigen Sie ein echtes Darlehen online, um Ihre Rechnungen zu sichern u=
nd starten Sie ein
neues Gesch=E4ft? Ben=F6tigen Sie einen pers=F6nlichen Kredit? Wir bieten a=
lle Arten von Darlehen
mit 3% zinssatz und auch mit einem erschwinglichen r=FCckzahlungsbedingunge=
n.

F=FCr weitere Informationen antworten Sie mit den unten stehenden Informati=
onen.

Name:
Land:
Zustand:
Ben=F6tigte Menge:
Dauer:
Telefonnummer:
Monatliches Einkommen:

Bitte beachten Sie, dass auf Kontakt-E-Mail:
chelsealoan4@gmail.com
