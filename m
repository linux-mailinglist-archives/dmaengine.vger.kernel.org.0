Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9559B5972C9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiHQPOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQPOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 11:14:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380469924E
        for <dmaengine@vger.kernel.org>; Wed, 17 Aug 2022 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660749278; x=1692285278;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=8+xya/+Ea5n0vP1GO3OYbBTq9gOf5N8D+xq5TVZ5ccM=;
  b=xdA7KKZNq1Hat9ge8JbtFHEREQNiOnUPTxNTM4VEbpKkIHiTO3OsJLUd
   SwF6Mm/q7b85M29z2x8UGccUs6XWwha9hZmIHaHdnO67mOnRO3lZSkbcd
   hwH/VZ2JdJ2yyYgIWEJ14BRCjLlQILzbqXAncIb6F32n1ypEtQjti8woi
   VPVVZhjmpI0HHMwrLyr63VYu/cso7UDw+SUyvFMbOLfcgBGWQEU/ranrG
   +EYKhI5a0WfqWqiaVQIKYech6obEhejeMmsDOcQtVHW0+lDXUBn6/KY5u
   1+dbyWAvhO8v/N3ogY4SA/Fe+EdA3kvou5eArVvQggZQWCb99N2EGt/Nq
   w==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="169718192"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 08:14:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 08:14:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 08:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcjIKvwVk+fhQDGpUeh+VCuvr4PoVVV3ScJFPqcvMBZjvMpbZpxDjcydw/6SVPvxf0AoHONj930IrC+XJ0dem7vpJL8c3TG93tsMOWbkatqLZ4zAYjj/9Ma8ITbFL9TQeyY/8WkLEpPPPZS/4q+Na/R+o1B1TcrBADOGebu0fpIgfPIaL58BApz8jWwzNhrY7w4AbfWHEEMrPab3zqmnbJPXI9PR3Wy9e5ssGL7+E2Uya9QDgxa0LviwrXoUGwlCtZkWruUooCeq+MskhejZ0PxFAkOk84IgPxGWl8AZyUQqS7h1QvWK92zjagOgCTcaxlD8w+IdKB3Pxp3NrMuBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qiQIEq05srp7+0UTxfwsrXvMsNBr/9dlOAagQSoHEc=;
 b=eNjEl11kdRHQXxuQdfr0DcCg52clfc/whCGWdpcskzXr0USpRjAzqXPGeLtAnIgv8DO0awjV7pWZ59/0ARMXQtWGESeu5WRwpq7Umvnqs/gzAhNW/9GOGripLGvoRvBnlRHa5CPWSbkx86AoaKxRkOtLLPJ+4TkxlmUcnK3AI/qIjb2mwQSxJppHkkjs6+LD0CdervBVx+AQogT4wDMLoTSmZHVSd+WZbTfHzK4W4u6k9PhyfCiYr7Br/XNHti7mkM8mP2Pcct0h2Ti8bOcpWYa0Fn+yKDBEbWXffBFFFV2vm+WYDg3chrg6ETrlO4FJzVxTdgWQKHUk2+gqcm88qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qiQIEq05srp7+0UTxfwsrXvMsNBr/9dlOAagQSoHEc=;
 b=I1Ys5rXEn0L4Rvkv8HmNMpERcOrECs5RfweXaileBeg4mITTX6UWznq6+dYUpDnJzGDB4f5gGUDG1w5jLdRYozdnro8KhHpdWp6CtNa7tm7ccTmA5Rf4B/lqwsQZjUOX3jM/QmwbO01EBVqy69gXxeFlwIpS4sn7THnXO4SxSro=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 15:14:26 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5%6]) with mapi id 15.20.5504.025; Wed, 17 Aug 2022
 15:14:26 +0000
From:   <Don.Brace@microchip.com>
To:     <dmaengine@vger.kernel.org>
Subject: Question about DMA devices and md raid
Thread-Topic: Question about DMA devices and md raid
Thread-Index: AQHYskpng8c5OaIvH06iHb8VD4Qd6Q==
Date:   Wed, 17 Aug 2022 15:14:26 +0000
Message-ID: <CY4PR11MB12387FCD3E0D939CBC89E2E0E16A9@CY4PR11MB1238.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 614e9b4e-289c-4770-99b6-08da80632c6b
x-ms-traffictypediagnostic: PH0PR11MB4789:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDKswZhHSth2MoaI/l1h5kPpTsTmJaMoZS8B7P5tWHzO5+RZ+Q1AmPR6xW+a4M7N/dE8sXFELlADqXIZjdG5DUG6VOGU/DMBVcN8sDiitp5QohIobL2nlVZXsKXUN86vZeDV8b/pSTno6TxgyIEx1NpEigsc9J7k8VL6kcSXz6klmh/4j4b2DoEVybQhJau+J+fQFUFvT27vQs6B0nVSDBjZOGeq8QWpUnspTJHxfHADgDVLA8dYsXmjoCOeoehXw/m1P0pff+cTFYoqiYck0H+n4GCuPXT+0Bgi4wVEH19ywrXHmnRWoWl8SNPCYq+uGxtg8tUVNMPgiQqzth71t92IoX5CHdj1Wxg/ZnWcz+6iq65/peMef57aXimLIEmRJl6GH9mnX1MzDuXY93ago0jF6bqDoNW9nHRhxKRdlVTlW8DfZ2xR8RCFBwX8wDpMd1Np+9SFYBCvWjSUZ3Wpny6p8ZY2v5t12lvOFm/olkTOYVfZxsKqGx/4zRLHsGKMoncYk3ZCr/m+eO/x6Q5ojS0rkSvSSSeqcnXRrmrClBbkbhocY9SBY7MvQQo0bWG205zsnbtEWOCiIAkvzlilYMX+ZNIeyc95ghBikBqr5bqc/oujOUA45kp/3iAgFLPvQ23gnnwQUKRTyX8yInGtfLNh+TilrkdwGnStX5aYWrYAyCS0l00LiWh+GKbb11roaaHWk1l5Uu223MY8aPQ7N/ADWlOv2ftwUR/EBKGzc4gvMRDDJynYslZ6vNcALNoFy+w0gBnnjmR8//e2Lqo6LjXOTPq7dDx+dnYBYHLvYdjDFowzb8fmQOGodrq6dC2U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39860400002)(376002)(136003)(66446008)(91956017)(76116006)(66476007)(8676002)(64756008)(8936002)(66556008)(66946007)(316002)(38100700002)(5660300002)(55016003)(4744005)(122000001)(33656002)(6916009)(2906002)(52536014)(26005)(86362001)(478600001)(41300700001)(9686003)(38070700005)(6506007)(71200400001)(7696005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LMF3X6kaO9QGXDs+uDHAyXb8U64OFTGoFRKLRzOu8mcAMk/w8j0v3ffoNZ?=
 =?iso-8859-1?Q?DfneVyhA4WonQakvRDOgRXneUrxXstzbR5zUWP/iLJuwIGdKr99ZN1ywwq?=
 =?iso-8859-1?Q?If2AWOIlJjGxCCIFR+oMTyB02vUwxSM1IO1bf3Q2Iyo+HaeTITBXjIZ7tK?=
 =?iso-8859-1?Q?qGMz1yrIi3y1hA9LuLQpgE0L7l6Pg1vYuOrO0x/FdoyWGi6O+B8cUprvQC?=
 =?iso-8859-1?Q?qpzmjji/z8ZbQEt7xMzkUy83DtSALfdfG2dPgtjP0jUGAei2CJ6SG91g8G?=
 =?iso-8859-1?Q?6OOPZ92mQSktt7PSvo1XIQJRTnrFGi4fSi/KMGuGOIeqrwycfI3ZG65Q8J?=
 =?iso-8859-1?Q?BwPYGBZfxBBgmwRl+6kBZJrrPIMdU3g9pnC0IuiJlG5vJtBs66n3HsaGqO?=
 =?iso-8859-1?Q?x+U+6RrrohkzZ7UtsUeFPcv7nc+AuXjOWGC7r7yVwHYo+j4QBFtss3j2+X?=
 =?iso-8859-1?Q?9neGGuQBBzANw7YHUYMhyGX5Q022o0w0jkO9/Otf7lzZG6F8Emi4so/ZQP?=
 =?iso-8859-1?Q?vMpWDQAa2BGOguy49lcx1W/KbWORzLEqgqvD9XcYnL/WVM8d+t8DetCZn6?=
 =?iso-8859-1?Q?yWXcfCiqPt8Gu+2ihjjbN1W5vreG3p6oZJICgA6EFmf0XRjd7cRQBlN0K9?=
 =?iso-8859-1?Q?19xFka7lA776tTYrefWq8FuQ//PIFQYJuvLQ019VLRpqLIAvBZg9yco4nn?=
 =?iso-8859-1?Q?4Jxs4+B3lH/JyK8bmQyncKLTf3n06XPbSasM8hmjaSUxS5Jgs+2E3pi8nT?=
 =?iso-8859-1?Q?s0cTGTTPxxTIcQyAJtMeZDBZSb3AijRysUZ2eVVdvpze83JjD+adZiyQw3?=
 =?iso-8859-1?Q?byAT3eQYHfiyZk5JCk6Sedeip90uwf2agMeUis2mx6HULMPP+3TqPugs/1?=
 =?iso-8859-1?Q?HjiJbB8LkSKp3NAfxKRDSDscixPtQM+51fldP3syZ0WW4Ljgr1HYRxX553?=
 =?iso-8859-1?Q?PxbRO2ohJJPba2WaNhf/EMhdOJF8t8WkVKTeEKTgnejHzTiluhyxsJMLgL?=
 =?iso-8859-1?Q?tnQbrjL4KI+qahTCEEACtTAVVvIp91vMsQReQPP4LYkb3HaFnUMFxGfY7u?=
 =?iso-8859-1?Q?QJ7LHO1ezfFOuMlkUe7TOn88Z8zw0vaNcyKy92VCIM/FwstStM2kZf7Cpc?=
 =?iso-8859-1?Q?zOVcpCtcOjv8vFDKD8kEgoS4RFjZkn9wdA0wcK4xAIfMfwoqR4PbjS6QzO?=
 =?iso-8859-1?Q?5LDPVRYheG9NPYuOonfSskZ4VOkN8EmJ1zJ7BPYbxK5pdrpsyjHKBhNzYD?=
 =?iso-8859-1?Q?bLzxbHhPwkWfu7Q76Y2zjUuSxNjl/LIl7dJ5/evtzZMS3WzwN8QGiU716q?=
 =?iso-8859-1?Q?U6M1wc3HZyibbDjUmPC8IEtsBV9dGSD9Mn9mkH2lhi0Q5CElpmr5hm4yF8?=
 =?iso-8859-1?Q?POwvmtmZkkdx0Lg3zmxw/pgv6tXYR+Y3ti+97W+UnGJ/9LzDxkH4wCYSUJ?=
 =?iso-8859-1?Q?TsKKQ3bjPjlnwN7PDDwD26n80wd30YBqJuy85YOM1NrrFkp1bnbg0ZxeZy?=
 =?iso-8859-1?Q?q+rqMHEjfHeXgzXri4lWsUUbc0zmRRyffJNasYIgWpFE3wZrNATJmP21uw?=
 =?iso-8859-1?Q?VOpfbhQrLV/nYx13i0tItjLEOibO98GWaMvZtaPztop63S/0ycrfYdFBqi?=
 =?iso-8859-1?Q?91SQOAl7yq2hRqKcpL29QeZ5YdQTXNPLeA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614e9b4e-289c-4770-99b6-08da80632c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 15:14:26.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avwk7HAkEds1sipUi+yWAumlHf1e9o7MuLCnCpc1ZG5fVhRM3+bv7ivjGANB7+3dhnGR7T4wfUYkyi3xzwwYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I have created an md raid6 device and added crypto.=0A=
=0A=
I have also enabled the ioat driver. (ioatdma)=0A=
=0A=
The flow seems to be md/raid5:async_xor_offs() -> crypto/async_tx/async_xor=
.c:async_xor_off()=0A=
=0A=
Here it attempts to obtain a dma_chan and dma device, but they are always N=
ULL.=0A=
=0A=
Some added debug messages.=0A=
            async_xor_offs: async_xor - Starting called async_tx_find_chann=
el chan=3D0000000000000000 device=3D0000000000000000=0A=
=0A=
So, can the md driver utilize a DMA engine? I believe the answer is yes, bu=
t I am missing some setup steps?=0A=
=0A=
I can get the dmatest driver to interface successfully.=0A=
=0A=
I may not know enough about how this works to ask proper questions...=0A=
=0A=
Thanks,=0A=
Don Brace=
