Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D54267896
	for <lists+dmaengine@lfdr.de>; Sat, 12 Sep 2020 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgILHk0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Sep 2020 03:40:26 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:31438 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgILHkW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Sep 2020 03:40:22 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08C79Psv026453;
        Sat, 12 Sep 2020 03:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=9xY5RuEOlt0cj+Xv8shz0Y/zFgenWEkS6JxNffDGCVI=;
 b=TodTYSiLm19cLZvEZnpBVgvOE3RwNBfdvYVCWmkMUOZVxtR73JkiR40efPtQZZFMpILJ
 BOXm7e82a4EXKmpu6PyoAeqAvhP9PihfhdbJxAVwYDhELrqrBWqsolXbWjxSZ9l4VLHu
 UHqYvQQA+i3zw6sjII0CS/KTEhA6fjcAV/6/vPNgbjB+lJgspix1R6x5Gtm5xMhSjhPx
 czT+pIO+IC7xt6ZXJZ100TOwC9JD2Qvi66mj5F38iJI81u0BIYdaNztnowku0xxgkXeo
 n8soVffZNEEIl8DIsEOf1U7zX6dvPjg7aDzN9hTuZ4ttoJZhL4vqp5ZVgKoUJHx9EEZ6 4Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33gsj881ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 03:40:18 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08C7EVqC075184;
        Sat, 12 Sep 2020 03:40:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00154901.pphosted.com with ESMTP id 33gsrvg5c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Sep 2020 03:40:17 -0400
Received: from m0134746.ppops.net (m0134746.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08C7XhQu109680;
        Sat, 12 Sep 2020 03:40:16 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-00154901.pphosted.com with ESMTP id 33gsrvg5bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 03:40:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC97R+Z5eW54Qu47ga+5J8bANbPfaxNfNghi6Pqj6yq8kqsFtfz7n4zviExMFj+IY26dn+Tym3/jE+47JRO9+hfT/opFSb+snb5IHu2K3OidDFy8e14qUcI+fTq9B20vqho6R5aKtyCyOHuMqsCM/DZyXQFzX4a2cP0aDUkENAq0neKAKPEUnB9AB1nFYD7or/gIlglzxMJ+Qidsj0b/00sJUIXnqLhD6Y1ukW+MfESlpmNcJ2HSQ99bLusbOyWhAnzdBl920tz7fr4krnrti12XexjKChf9YgTfaW88RdB42ATVWIeTsmA+AxjQK/epDZJFJgvR9MKoE1R8HARfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xY5RuEOlt0cj+Xv8shz0Y/zFgenWEkS6JxNffDGCVI=;
 b=VAxI00ozzTwtksC5pse9bnohHgswVJFPHj16YeCq61N2P+FHo7VqKp0uacGXlPtb1xPmT2wUvJUfd43oBbI6L0rjN6SGgzWsBgIv2y5WpY6E2KaBQk9X8DX07LVyM7mCuahqv8Rd8V0qufKvAiQhsWuzdnrQieCyVTyLMFrF7l6E507FP5SPVaUfwcNp7BEbPUUlgY4hxPYCV9dGG8vwyBduKXwV8Tps/gFVQ6As52JRkm6uQD651wmBbZfBT1kDzTfxQDrWB1ex+K89noZVuBPG8BGZaGBDWlVpPzlJU41eTRZtGfwg5eP8KreY1s2aOT0ZwHrbfhc8Kb4WAckSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xY5RuEOlt0cj+Xv8shz0Y/zFgenWEkS6JxNffDGCVI=;
 b=q7NaguaGtEvG2ckqibiW4Y22oh5bIDp/jrHxiYczn5GWqZVCDT99wIPBg7nVHlZmMd+H/OzZvyOczHHG+Bvfg7JNmsi1d7Hk2sZzGO2BC9w76VoJSd7FakZTGeYMEZ15VUpzTgDJlH3eh5KEDqcRjgdEmgWuSiv0t+IeWK8McKs=
Received: from DM6PR19MB2682.namprd19.prod.outlook.com (2603:10b6:5:139::14)
 by DM6PR19MB3595.namprd19.prod.outlook.com (2603:10b6:5:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sat, 12 Sep
 2020 07:40:15 +0000
Received: from DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::ad62:71fc:608c:53ad]) by DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::ad62:71fc:608c:53ad%5]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 07:40:15 +0000
From:   "Ravich, Leonid" <Leonid.Ravich@dell.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH] dmaengine: ioat: Make two symbols static
Thread-Topic: [PATCH] dmaengine: ioat: Make two symbols static
Thread-Index: AQHWiNWLhOQ+4Vw2b0SPswogXUSCUalkndfA
Date:   Sat, 12 Sep 2020 07:40:15 +0000
Message-ID: <DM6PR19MB26820B0B8BDDEFD7E94A72AF98250@DM6PR19MB2682.namprd19.prod.outlook.com>
References: <20200912072158.602585-1-yanaijie@huawei.com>
In-Reply-To: <20200912072158.602585-1-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Leonid.Ravich@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-12T07:40:12.7082332Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=50be77a8-39fa-46e7-9ad6-d4d4a934e498;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [93.172.200.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f4c5059-80e9-403c-7219-08d856ef16d9
x-ms-traffictypediagnostic: DM6PR19MB3595:
x-microsoft-antispam-prvs: <DM6PR19MB35953C70CC1C4892886F2CA698250@DM6PR19MB3595.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:53;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LogUwsbzr0h5vHOvM+M8O1nNoLzQSF/iet3d9umhLIgxEhxLNBX7uq/bQ+9WcLBq4QHRj52fEvcyOy60jPND+082jpCNqIFOP1C5UpWHE/O4q9c6rHBm0s8LhsgEiFS1NCrNRw7iJpklm8Y8F1VdHPvw1daYp4yI1v50jTKRjnslBh5JjCysKU9SMWgqS8Y+VRg7ICpC++9V2JCaLVkmm4vQOqKCxfYVIVUq5QsIRQeK0c91ud5b3a+Yb3yYscp+sTC9g14TyjROdCTDSqtXxc4OnqWaBpQog55NRaTTM+WaE254KS/VQBFLNwkYglacWKc5RpjOZms7UPsblQ33Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2682.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(66446008)(66476007)(33656002)(83380400001)(66946007)(7696005)(76116006)(186003)(316002)(2906002)(64756008)(786003)(4326008)(71200400001)(5660300002)(8936002)(8676002)(6506007)(110136005)(52536014)(26005)(66556008)(478600001)(9686003)(55016002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bfwAG9VQQw0xNZCLCNl0Xgka2WL2LA2UcELUwUnuPXh0481M5l9PlsD11la5M73xa4G8AjoiIjpRBQemqdxPjNrWmjMtE95LjyyQZu52EJ/Fj+YY2eXnqNXW8NyO3uc/mDDsqyqAbtv4khFGd2wfiwfwPYNydskwq5nRtDYJTRF2f5/7wy4wRCM1KV32CWLI+UfBCZunYcgJ/+6ZnnIl3JTZKONQnKRZmomcMnAyH7nZomzTVgVseQDbpXSJfi1HZGoJSYQ3pvkLgZWX1o1WnpZkE4s9itS5YRqouB22eEPuLdgv9zCPp/V0cuWaBoNR/9BkhLe+gODYvb3d08A38azmcw73czG/ktNQ7QOhcgwiO4HU/BRlCwgy3hBIggCFhAuTv9Fobx+nM0+7WalTLxdbqswypG/iRa04nJmvdqBN6CoCutmpAVSXuM4uE700jbNztGHY1egCeYyVWZu8FD1iMVu0EIex2mVQ52R7fO9Li8laqv51pvTu9S/O7hLY4QtcFjmUnDV3uBxYKGLUeBHJBJkEetNK0XjkjBkpLKIlU59hZJNqwFYmbMqXOQR1cfNZ9d9sALm8iehCIp2ZNLlAYtlVq2E+0hPl/gdlQMTIdsiN66JxFQjIbiq4PYn44tqaI0ZxH06Q6vEZWBQjdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2682.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4c5059-80e9-403c-7219-08d856ef16d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 07:40:15.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFJHekpR6YQWQtXTay5tM99AeZ1J0FeVu0JDzLyG7PGhOh5P6s2L362A4RVkYBxy+FOgHICDYd31KJX+5lpqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3595
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_02:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120067
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120067
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Looks good to me=20

> From: dmaengine-owner@vger.kernel.org <dmaengine-
> Sent: Saturday, 12 September 2020 10:22
>=20
> This eliminates the following sparse warning:
>=20
> drivers/dma/ioat/dma.c:29:5: warning: symbol 'completion_timeout' was
> not declared. Should it be static?
> drivers/dma/ioat/dma.c:33:5: warning: symbol 'idle_timeout' was not
> declared. Should it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/dma/ioat/dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index a814b200299b..8cce4e059b7a 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -26,11 +26,11 @@
>=20
>  #include "../dmaengine.h"
>=20
> -int completion_timeout =3D 200;
> +static int completion_timeout =3D 200;
>  module_param(completion_timeout, int, 0644);
>  MODULE_PARM_DESC(completion_timeout,
>  		"set ioat completion timeout [msec] (default 200 [msec])");
> -int idle_timeout =3D 2000;
> +static int idle_timeout =3D 2000;
>  module_param(idle_timeout, int, 0644);
>  MODULE_PARM_DESC(idle_timeout,
>  		"set ioat idel timeout [msec] (default 2000 [msec])");
> --
> 2.25.4

