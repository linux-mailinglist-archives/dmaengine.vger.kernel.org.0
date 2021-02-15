Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4931BF52
	for <lists+dmaengine@lfdr.de>; Mon, 15 Feb 2021 17:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBOQaE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Feb 2021 11:30:04 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46050 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232013AbhBOQ2C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Feb 2021 11:28:02 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FGKjGe030103
        for <dmaengine@vger.kernel.org>; Mon, 15 Feb 2021 08:27:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=TFuvtIHztjibq9q6MTYVgTzC38samXyQekyXU3Rr6e4=;
 b=Dj8ZOfI9tl2jxUrA28zESrGV/7DjVMkp3pfT/NFzddn2oi+MdfAI0FI6pGQIeHTEPwNp
 KdAry724PbmMH0LPKu9WTOb7OplLv4fTFjC2i6cw6D+JFgjUhRrsOpUKDxAH+UK/34yT
 OK0zY8IwHPHU9Nch+HSsqwqxbwnYVEIK8oua82iQeIfQI6AyCNNgX6B4Gzae/7Q2238+
 bAzoi3LsPAfBElPLio34OP+UJRfgoYI5uXgwtvoOgHofWCZovA823DfhFRuC2sVY4INQ
 TvochaW2IqflL14NADGF8a1YMw6aBsIhvH5kTHlZy/DIpOGDS/7JNGmv/PjD8pxIiQYo xg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36pd0vmr2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <dmaengine@vger.kernel.org>; Mon, 15 Feb 2021 08:27:19 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Feb
 2021 08:27:18 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Feb
 2021 08:27:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Feb 2021 08:27:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH5iwu7XnTKilweeyu7nwxptAqYI5yYWkDBcj7NWg9xQV/0hle2UYzigrcnXUgfy3sFdfmRCGzLfTlLQqq8EjfZ3lqtyikbrlX8F8JF9ZFjqMt4iUL35SANS9WBYZdFBcasbok5GtZ8P3Mfx347HWywMjEh/OiFkTnfuDHQLS6CFEQ1obQhwS23OSdhSnkKUmnnOMGTkv20rMvxiHTcDfAfJhj9LQglu0oMk8yPzniSeXoRKuokpyr4/kGza37BAZ92QzzGlXR74K/QdFms/mhVqO45sXpFE8y+WDlE5wpzSBbdALS5hsOk/qnMJwxyRd32zW99gm6bF0JnK/L3JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFuvtIHztjibq9q6MTYVgTzC38samXyQekyXU3Rr6e4=;
 b=ZEdHayHioiqVKNFU3uMcguxnQKuZes5ub41GgmU80QjlOtx9c0xVomYJQGoy/6xen2vbIy50BDd5Iwv9YBPgNj5sx/FvfemHl5TGj0EnJeGKxt6EcpagDMuVDqxoal+wzrR8bK8kgg71O7WimMCi4xZIePHI5uWVCEgYc9dg5Y/UH8zhfr2tZ5ujwqQfxbOHr3HvCq61NbiO4x7FJQAP00Yn99X97GsRtwXcXleEaoSXXU67SSsA/uCXYmqvKNCI8AocAhb7G2ihc1LBsokE58TYfgQM71aNCw4rUa6IedXRvWZGfzIkyZ83G4qXkq/Umd7EeUewFTanV7DGqHwQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFuvtIHztjibq9q6MTYVgTzC38samXyQekyXU3Rr6e4=;
 b=p1lYCAG9/Bv1YkT4qW3zh/4oKLZHUaug40QCST0yBZgkWZepd+pMY0FLjYoDgmU5eU26Cr75E3CA7nv3B7rsvhbuvL7O/8HiELYjoEQfuFeMKRGghe2bSDDFnVwuGo5b5mBtacAIcdHoKv5f9eNKoe3BKYwPe+zev5KJEtqZLV4=
Received: from BYAPR18MB2741.namprd18.prod.outlook.com (2603:10b6:a03:104::31)
 by BYAPR18MB2565.namprd18.prod.outlook.com (2603:10b6:a03:135::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 15 Feb
 2021 16:27:16 +0000
Received: from BYAPR18MB2741.namprd18.prod.outlook.com
 ([fe80::fd33:5fd8:dce1:d322]) by BYAPR18MB2741.namprd18.prod.outlook.com
 ([fe80::fd33:5fd8:dce1:d322%7]) with mapi id 15.20.3825.039; Mon, 15 Feb 2021
 16:27:16 +0000
From:   Noam Liron <lnoam@marvell.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Question on DMA mask
Thread-Topic: Question on DMA mask
Thread-Index: AdcDtgolUaIYpBV5Sm6veCqgg4kqeA==
Date:   Mon, 15 Feb 2021 16:27:16 +0000
Message-ID: <BYAPR18MB2741FB46892B3958F843A637B9889@BYAPR18MB2741.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [93.173.245.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90a3bbe1-4113-4eec-7ea5-08d8d1ce8edb
x-ms-traffictypediagnostic: BYAPR18MB2565:
x-microsoft-antispam-prvs: <BYAPR18MB25656A5C24AA63A937BF4B2CB9889@BYAPR18MB2565.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bxv5TWzz5V2Wnftko7YSBTnmSAr0StkZZv/yZBDWONW6bMNeS5rn8yAWxXNtAd8wwavQ0u71rjtuJSWqk39fkxOVNPHzyHKOM0QuIBuUaSxfRHu6xyI6H4KOcPG6OMZFXCZGorV0hv459rJig01n6fEI69aHfThMnrB53iheaGxRoI8TasbDQYGJ9+bnyR3QAMlhjI1krXVx9YAFmkuJs1UbdvRFJQWOo+jBeae6HJlcil2Iecx75Fs62guoJMnEyA5daeeEaZQsdxm8ChpdMgO67CmP7cdlNCZ1+Rassy9H1YCEXVTGXDSFAZr8AACTT5CaKr9cRo7rXzgVpQMQUijTS7u7TMYZoMwFounvN2lH0e02yopPBO5fz4n2AnTsxsir5NZBh/nyix8Tryn9sXMRYyM09AHMHTqqqMpv0sqmytFbhJXCl+vSWJbMOII/wbN/ZQIOJgAj7PeYWbmyp3+SXRXHJ0o0aUHqRVI2tTCwU1xsx+sGjvKP/IgZulRtd3smyw6Dyr7PP8rbPzhTKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2741.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(366004)(478600001)(4744005)(6506007)(71200400001)(5660300002)(76116006)(66556008)(8676002)(316002)(6916009)(66476007)(8936002)(83380400001)(64756008)(26005)(3480700007)(55016002)(9686003)(2906002)(186003)(33656002)(86362001)(7696005)(66446008)(66946007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zCg5MQ/vkZMZ7JCpfzvex40JQaVx89Lh2YyDVd+Ry2TuVzWyjVZibEe01dJn?=
 =?us-ascii?Q?7RSJ7MpN5Xc/9BxnliktHTxYdwoapN9EMFOVpiCjBsQHAcR/3WCem6F4Ghth?=
 =?us-ascii?Q?fhNBAe6k79ty5RkiUX2oEskkHW/DPXiJp9LcfDA2/3SMGqelVQANwckgG+H7?=
 =?us-ascii?Q?WtQmB2FVLYyNgbGR8DOmpv7tOKqaIDwnn2qOaJvh4mNDe3w0dND1NtZWIBpu?=
 =?us-ascii?Q?ZBFhKvLRkEV8XVHcGi3Bh7+4sHJNnQzZiM/ocygQKrYphCxENgZr/hUU3uxk?=
 =?us-ascii?Q?eFOzHWyK122U26D4ofgWMAKm/8nnMureGh1rcwIbzxGxc4fIYfYMDUf0KfaT?=
 =?us-ascii?Q?6olqdp8QUK0SbLl1OZGjgdNJHx3bhkg5hJwgtv8hmUkZdlxKVV7AJSnWNHEg?=
 =?us-ascii?Q?l7swv7Atw5HVWs1qqn1QXymx7nUh4vvfJ8/30mhfYvO7dXcloCLIEUiFqmBS?=
 =?us-ascii?Q?j415dhJ15gVtp4thLkJfEeadXlJzQ0gl5tphjeNqmrJAqY2L/0qCOst9TFsn?=
 =?us-ascii?Q?xYxztAQZcfIRLEeT/MTcPi+gBXW3E9H3pos0mpZ9TiHmS2T0XejSCWCIEklx?=
 =?us-ascii?Q?rDqq6TauLqMmB/TF6DRKuTOiDv+3nW1haYHGdoXLgdtwDE9K5DlpGnp7HqCl?=
 =?us-ascii?Q?RTHi6UspVTfv8k6QOwhJdfo9l0Z4eVwoHwfbIGx0WHPrEaTavsI/9lAeLgY2?=
 =?us-ascii?Q?VBECaHNi8eTQZr2lJ9f14cXFWix+m7uRAzn5MUN0LV9KsP4e2xOWqN+/aNWP?=
 =?us-ascii?Q?USdYqbMca4s8fRWsT9UmNo30n1ZqazGELA0okdllmv0KYb05c9MLMou1LIJN?=
 =?us-ascii?Q?6DkwtecAOF+Rv7LfB1rR8TxZRcaFbp1MSZXtvVRDfBW6j1cQT5jxc2K8h3zV?=
 =?us-ascii?Q?AaSPm17j6MLPY6+QyhhwRHIbK3X1IGjonErqtBTUxLDL0Zqstc2e3X3ovXdm?=
 =?us-ascii?Q?RD6GwpzD6ZJGmMN/mOlK8Y7RlpWYL+g+QOZhBqlkqpbgd8cqsW7TNFfB0Hgk?=
 =?us-ascii?Q?hvWLZhxyfYJQDSJrT2CCbzfHgR4ALn+4z8TP6ids3ZcuX+1CrpBuoCM49VNF?=
 =?us-ascii?Q?VuKN0koyf+FFIz4Jc35yGKk9DOpAE1bJvE3vDyuQirVJOd+bjWddyuq+wQEV?=
 =?us-ascii?Q?adrizLLWYbtc4kGBdS/9AKkCce4MnkONExWM3A6aysYzgEfGkFeNk5C1l/RO?=
 =?us-ascii?Q?YDa/1o5pqT+dTBdLZgGku4DYchcTpD8/xtl9i8dqU+Hxzb0VPNPH/YW4Oj4c?=
 =?us-ascii?Q?dGz82rcZ3Tzf1bi0NT/BakzW8yEQwXvNG5RjkpKizpq0I4Uqfl/kaeYrXmmx?=
 =?us-ascii?Q?9XrDnn4r7NZ23Kq/Cr+mg/oU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2741.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a3bbe1-4113-4eec-7ea5-08d8d1ce8edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 16:27:16.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXmeJVT45RU6qV4gbm9cfh5Lcuym7z7oa4xIH8z5XIa/jlJrSrUAFZDoOEDAEpeZiWVkVP+uLSEbxxadPTVqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2565
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_11:2021-02-12,2021-02-15 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi everyone,

I am working on a SOC which it's RAM starts at 0x200M.
For some reason I need to limit the DMA allocations up to 0x220M, so I call=
ed  - dma_set_mask_and_coherent(mmc_dev(mmc), 0x21FFFFFFF).
I noticed that dev->dma_mask  was not set, while dev->coherent_dma_mask was=
 set.
Still, calling dma_alloc_coherent returns buffers above the requested limit=
.
How can I limit the buffer address?
