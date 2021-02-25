Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B5324BBF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Feb 2021 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhBYIIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Feb 2021 03:08:07 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:25366 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235586AbhBYIIA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Feb 2021 03:08:00 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P80KuY005157
        for <dmaengine@vger.kernel.org>; Thu, 25 Feb 2021 00:07:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=Rv41hvwE4px6ZDWZOi85FQl6m3J2b/prOjfZaQ7b3BM=;
 b=dGRIOs5tnPj2URefoP2zZInmie+4e3IbrEGNa03DNmaJpLKDKl2emMXSBt7Iy1vk4xxl
 J2M1EkGeQce+iKRA5enKTk/3HwMx1mRJQUXADppbxdgWbGpmsMdzbZyplSBHHmxBDS6G
 JnKZRqx/kjzAze5y/ogSH0F0wXzcSWYERv68J+neCafT0Zje+2Vx8ex/atmg4jS39yKy
 LDiTaQR/ji1fC4c4MQDBCOmdZPtayDEPO9ADZukDQnSRsWaBPF+6OBWXXh3aGtj+xUQs
 /YsTerzKmo7X1a2a4zX9zO9MD2okGvbJVco1u0yPrPXxNfINVcccSEJuw6OgBdTk4u7U ow== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36wxbv1dkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <dmaengine@vger.kernel.org>; Thu, 25 Feb 2021 00:07:19 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 00:07:18 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 00:07:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 25 Feb 2021 00:07:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUOwDmEmUlyQ4un/TEyyw932aU9bkyi+bV689vmRbwFVb84UcmLC0LL2Avlpr37Ib51Om7aQNcAbNPvN/dlzc/JkKbPT5Upb5c7eqQR/F0pjfJ6icVPYNKJci2QTfczG/fnk0QF0442eej87bLeMwbdAIbBnGFizchfZKHIL5gokniONIpXHM6DkDRqWcBEwh34lMbjDJa3h1meKmxwwYrT3raJHA93tLfMMBRzUYhvjCEwecieCIjMwInoe9i6MgLgnJ0SVepNskZpJFrC6TmpmRfPaglHy80Qw9FL7qfeb5odLoRpD71vg6xOKi0RIQbBoS+EsmYWsLHh+apAO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv41hvwE4px6ZDWZOi85FQl6m3J2b/prOjfZaQ7b3BM=;
 b=kaNCFIWOzONvO8Xhq8hHROZHiXW0dmmELqy32wL2DkUIWGILToHGWqsMj3GYKGnMuPkMLim4SK/J70IW6C9Ng+KxIHrbCwzya/utL7m3fOzrRFpCc7095uPDOssKxl62eYfKrweq5p4aBBcatnbOXk5uphQeKgj2trv//xT7uAaUgWA9aB3eZrc+H426QjbWRXY0hAQ3iPyNaLRTbKsDsrFQCJ3cHecEWxBVWNJVdj2GE5D5lZM9DzGkI5sB994mU6BqXpD9zB/dXfMv6sp4dSVZE5FY1V9vvAqmJwwN5KFAJGKVx23Q3KiyXf+e0VPCaRUqAclmxVoNTUhvu5rEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv41hvwE4px6ZDWZOi85FQl6m3J2b/prOjfZaQ7b3BM=;
 b=BOFYgvqEGHFCzG6Bd0RFE74tOpWwIVf67EjPLNImOf8J8Jm8j2C8BuQQkpNrKeZ/kEwVPIIa/JsBYb8rqf3D/21Rm+uAHOrKULehxA3DqhDLD6C4a5xCuUWdQvTAfxDTU0u6f7vzVzpTD3rgGbf7xv0ik6Mz4REwRqa1PsKUyLQ=
Received: from BYAPR18MB2741.namprd18.prod.outlook.com (2603:10b6:a03:104::31)
 by BYAPR18MB2869.namprd18.prod.outlook.com (2603:10b6:a03:110::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 25 Feb
 2021 08:07:17 +0000
Received: from BYAPR18MB2741.namprd18.prod.outlook.com
 ([fe80::3175:fa63:b9bb:f3ab]) by BYAPR18MB2741.namprd18.prod.outlook.com
 ([fe80::3175:fa63:b9bb:f3ab%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 08:07:17 +0000
From:   Noam Liron <lnoam@marvell.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Question on allocating to USB devices
Thread-Topic: Question on allocating to USB devices
Thread-Index: AdcLTRmfD95zawQQTFKsWbvSa4tSSg==
Date:   Thu, 25 Feb 2021 08:07:16 +0000
Message-ID: <BYAPR18MB2741C046E509A896FC4EEE17B99E9@BYAPR18MB2741.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [93.173.245.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31e5c04d-6589-4ec3-52b1-08d8d9645e0b
x-ms-traffictypediagnostic: BYAPR18MB2869:
x-microsoft-antispam-prvs: <BYAPR18MB2869F2D51C1E05B9CB1062DFB99E9@BYAPR18MB2869.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cbgfn7ElpN7XYxCl/0GE7WFZamsHd2VwJLVl9YmPo2AuAlc38W8I87ttY8Di1vvtwdXbfIAqpOTAhINg4I86Euhcbxi/654fPfPt2ZlTU4cv8fnjyhw178My76GOVZV9M6xVWIIDzDHSJ8v3WVK3fp2D4XIWLxaL92X+iQkl8CNsxcxU6P2g6a7zVzmp6EiADL7FPcIYTK7xqZnzTpA2xz4qeUoFgjKeEWPZgmyYksudvGaufxeLdQqwjolaYGCSVEERuaokPmZtZkWTqj85h2eFfnoDwtK9477ryBn3w6zJ3MMpZGwojRjGe4ZfOiKmgt7SjtMaROPDkd6O1pZf2jcsKeO6u3ZuDDziNP+DRpazKctlv7/Sw3taDFxTnZt4sfYaMS8VeuCF1Po/QZ5hJc5EkIb65Zuc2lRsU8gJPkc2bIGl1mxuUhmiMoKamtOzJFslFpi3nxmgvymE9Te0nROcmEB7v3uYNWN1s5eZU8u7zUUNDvIITb1bMxFrR8U0k8cneCh3QbFzrVrw3ZjUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2741.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(316002)(4744005)(2906002)(6916009)(5660300002)(76116006)(478600001)(71200400001)(64756008)(8936002)(26005)(66946007)(186003)(66476007)(8676002)(66446008)(55016002)(33656002)(6506007)(86362001)(9686003)(52536014)(83380400001)(7696005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?hdZxojDK8+ZImujZWRkLRUiVRLGm7QE2H7eaCdGRT2xgD1hNoq1gu3UudM?=
 =?iso-8859-1?Q?STXtpxKrXDewbfsnd1N1DMPxvjXdPFxeu39foJTI72U1SipCfO2bPx+mm/?=
 =?iso-8859-1?Q?zgdAqxmd8Gs+d5LTjzraIwKIYpViG64RxHxXSKSW1Eg9GEH619zX64ilTJ?=
 =?iso-8859-1?Q?6BkBtauam59pWWAoSJXaU0Xe+rasmhmIIYih0LCMk42DeU/defg0HZ6Sfa?=
 =?iso-8859-1?Q?f6QNPlFtVGyWe1ZZfoOpar3RSHAjvfDc+MeQAA1ZOf6d5NMVqzx4aObxTi?=
 =?iso-8859-1?Q?O/ndyMNszWB98/sMt2f55K7hkuxiDLob296guahuHLUQcouFFCEUYD/qSu?=
 =?iso-8859-1?Q?hexMegQKbg9Ehp2GV3SUDWKpAacFplE5My8HoU1wYTy9oFjONYsyEnN/F2?=
 =?iso-8859-1?Q?dzSrsPZD8M4bDUUlGH0WcEuT67aXAPDx30eFa2bvwFfslhzVpmkG3HxfIa?=
 =?iso-8859-1?Q?LzsfL9u3t24f69qA2zjQY2+j2gY5bUd/f0FKFxWRLH3a95xzXd23dgJhY0?=
 =?iso-8859-1?Q?MtSXo5IL0AlMHhZX4MA4vSWg52moegDefjgpira/VAQ9W9ExZQRpb8ldz7?=
 =?iso-8859-1?Q?2lgPEdgW//AE3nkEdYgsOR1cqsSrPV3yYA/vwSj4IcdwMgBtnV/TqGsYrd?=
 =?iso-8859-1?Q?/KCf83VfgpRIDK15MGG/PMVm1GHnBD3NlDa5VF9nE8bIWE2yvLwhihv6ra?=
 =?iso-8859-1?Q?aFjJ/MkhfZtjPyxkLge1cpmeJOuXV+CBV+egQH0dtizjQ6bqMvDEsb/liI?=
 =?iso-8859-1?Q?UsRWDlx0qS9Y5Nm4ZUwRY6w3vZ8gSF9CC7PT/9SiGQhprtXMYteUEubojm?=
 =?iso-8859-1?Q?xERH04pYxqKfkp6xvKm0xG33r7ywNLr8+wmW6m6ZrWHENpT3mY36KUubZA?=
 =?iso-8859-1?Q?K5qeMxmjnOZAAXsrlWuP60lYYDTQRXAY3IlkAwN38mVPNcC/N8ifGVUn/h?=
 =?iso-8859-1?Q?whE3Zx633aqJnMog3qhVXjJPKJ+dMWXAk55CmxgLQQGNwgSXezNp+QKqn6?=
 =?iso-8859-1?Q?HQPS1AZTnOibM7oynx7soQWx/Hz0JRhGa9+DEKzaplR9Of3n74GM6CBoiH?=
 =?iso-8859-1?Q?4poHa/iyppdnJt0Nd1JTDabvT/pQYSqPLJPuuD+4PFRL4SbH/UEtTtiVRr?=
 =?iso-8859-1?Q?mo8ffVtsDOqCmg4AWS091I7VVgWEqrDdrKGsz3DwLHt5Sn0uQXOtH10BrJ?=
 =?iso-8859-1?Q?gOPI8K66scAwJlrOsvk//25aVt5ndjauie+15CMn7HD5JQ0BSPqMLG6DZw?=
 =?iso-8859-1?Q?lnLvvU/i64tSmR6F7MjsxvsU1bVCvIHAn2meZyWmx88jbezIvJVOLrVFLW?=
 =?iso-8859-1?Q?kNevFy4zsmjMKQSMD5HhRcK4QU3aKLPNoe4p67j1f6QDQiRv6pxYfz4JXI?=
 =?iso-8859-1?Q?A2isv4Am4O?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2741.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e5c04d-6589-4ec3-52b1-08d8d9645e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 08:07:16.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOf3cO9VINxQBCvyrpXMUdSlVgWSi/+bAyB7bY5DRfbLjRmoBfTDtXz+yAu8ZjqTwCk2WT7to9rMBR9ctDOoQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2869
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I am working on a SOC which it's RAM starts at 0x200M. For some reason I ne=
ed to limit the DMA allocations up to 0x220M, and I've done it by creating =
a shared DMA pool in the DTS:
reserved-memory {
    #address-cells =3D <2>;
    #size-cells =3D <2>;
    ranges;

    reserved: buffer@0 {
        compatible =3D "shared-dma-pool";=20
        no-map;
    reg =3D <0x2 0x0 0x0 0x1000000>;
}
which each platform driver in the DTS uses, by referencing the pool:

memory-region =3D <&reserved>;

But how can I enforce allocation from this pool (or other reserved area) of=
 usb devices such as usb2eth dongle? After all they are also devices (probe=
d at=A0usbnet_probe) that allocate DMA, but are not represented at the DTS.

