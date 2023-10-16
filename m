Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A707CA665
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjJPLO0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjJPLOY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:14:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC019B;
        Mon, 16 Oct 2023 04:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrp2L+ZaH223U/dI2f1Q6ywuPSnknjdftJIvNRNpjlvFEFZbv8YGEh3Ke6npea/V7HEoHevWPV0s5Cx0U1xxWiWdHShpULl9lKx/f0+JMWE4/Ldp27l9ruO4nH2R4ic1LMwDuskPNaULEUh+A4EmXrf0zR1FUFdv6PUVwgKNUckWOrvaLVZpWkTd8047Zhea2Q7UAmGcWP3gRSj66PRZHgIMrgkaQB/gbtv6W5RP3GJPOIXmK2xyJsuIs53baoLvpekAg2z4sCH5ARfyICDPdP0ASObMWQUhSZyJiPlxSs3DyFWW3WlcDpGNmrvYdISTaQax1E0Iu6fLBNSwAg+ZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkwRKNjIixJtYP1qOqz3YawMX9EoxTGUjkPstgWT6QM=;
 b=PCf0AuDv8fK5ymwMCjwcqX1auSqaHYW0dHWD9EJbZeHRypPs/YtlWcQcI5i/bduWZgL6no1AlahzkVK6d2ZYVfkwSrkOrL3EPRATrZpjv59Z6zg9ESpgXCxH8yjnTL0AnI2fqtSD3jeOHAOU5kp18ZPJ+bqDRhySa7UlN2F4kplnDvew7SpB/rJzSWLrwvEBh5XrS3W/OWMPW5jzgNFdQOhbwohQ1tUBlVyF1vYMDdjq3FrrnAcEeTkr8qpTPxFvNCOJnzCeMqJP7oac8RuiT6AG3DqSNLVHuIuf7XcyqzvMuGIMRICCAkzR9EyCH3TGpUO+KEeqUoQubZoS6CI7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkwRKNjIixJtYP1qOqz3YawMX9EoxTGUjkPstgWT6QM=;
 b=aqCvJYgWirO/YaFN1115uZXZ7K0QvC6bfZd558yE34UvMyAh+sOFQFHiypvptfFmAT5+8JotJELAhHeTYQZym1g2uhqoN16QHslrCuu+ao3sWtIEoeMVAzSQ2o4ukOPly1DYDnUYCP+bJrSgEN/37BkKA/I07fKzRTtRmHS5aaXEvGZfzABAi2QEJjpIAdpjtW2Ge+N+LEzzjGrXpoapsyXfdXUnat2wM7iSS/VonL3Q3I+OtAqKa2HzFW5HfJcN5quRu+oLqi8XL+JFzZ8Rf9qJULrKRSv+V4RlESrJjpsG9+zTlTchVz3h5DEpBFPL18R+LnGfurMcGiLb2qTS6g==
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 11:14:00 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3d48:a382:4b73:8387]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3d48:a382:4b73:8387%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 11:14:00 +0000
From:   Mohan Kumar D <mkumard@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 0/2] Support dma channel mask
Thread-Topic: [PATCH V1 0/2] Support dma channel mask
Thread-Index: AQHZ+nrP0nMNq+9+7EGmA8rjAO2gebBMTWwAgAABMoA=
Date:   Mon, 16 Oct 2023 11:14:00 +0000
Message-ID: <DM6PR12MB4435D21F738FF9CA2662D79EC1D7A@DM6PR12MB4435.namprd12.prod.outlook.com>
References: <20231009063509.2269-1-mkumard@nvidia.com>
 <ZS0Z2G64rjrQTobg@matsya>
In-Reply-To: <ZS0Z2G64rjrQTobg@matsya>
Accept-Language: en-US, ta-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4435:EE_|PH8PR12MB6794:EE_
x-ms-office365-filtering-correlation-id: 1cc01065-ad7a-4ac1-1e72-08dbce38ff98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldyM2PqGq+WFSbDFA94nDKVH18ZDHlk3sNydq3bFUZRehDXKTFzz1LVPz2TMMp+GW41I8+8es/fL4CJ5qZ/9QKvwWvZu4IUu6xDSISWnddLWq0qwRx2/pzllIi1UCjYTqdTlzD/gzbdjclCgeQpIgMvkgeOn/ohIvleBQUA7NnWUmdpp0XD10O16eQSPd69KPpg5VyEK2Mao1JvFJ8HDcuelstYsTbxc1GsEQi47GnhupEi/CwXIGQlaoMe8hKdfQKG8Rzn9W2D2nqayzhKulTmULpwyhxk4s953hn+Hvo4EBKjBeNZm1RzzC624Xojqc3vGt48xy/FFe7gQFyzMx3YubGDdIqqI2swDCgDY/EMKQYwL4e+3FXvxUhcPzs0OT2QwWOeD8qlbdfRy0TSwA67b3r3j65He2qLG1EyvW0aIBm4lkr2S6kLk5Q+IaxqVNnWwV1LvN6g4lGpiXIRlosuqDWAumPOUbNlX+MGXuiFnV2pioFYo3bEoF+aVMPXGGHkvU4NWPcmv8YYlDyODsC1ebuzZGRF8agqzftoTImjIZ+L78C37wpS3cFvDibp7GIWY0uhbAvrAFBRQU6s12XBSGdxobr+LPCspHsd7dAFplWp06r0RPDTTG8H+ZhE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(33656002)(71200400001)(478600001)(38100700002)(5660300002)(122000001)(54906003)(76116006)(66446008)(66476007)(66946007)(64756008)(66556008)(52536014)(41300700001)(8936002)(4326008)(8676002)(6916009)(316002)(4744005)(9686003)(83380400001)(26005)(2906002)(38070700005)(7696005)(53546011)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z20b4dxyuEBHnEEqMU5vL0CVtZnyTEx91ZH1CMnq37KMM/Lb7fb0jHTHTVD7?=
 =?us-ascii?Q?rCDdiyF8vcRQzybzM6FMAN/ruALPYRGuQA5880NT09PxhnW3yAuH6T30EzXp?=
 =?us-ascii?Q?Bn5goNHT+CtDKMlI+LCazqquSv4EASWAMRyHpPCtGcyo0U6ABvyWKHWxOWEC?=
 =?us-ascii?Q?LykqpvDHMyCCWo96GbEVEJ3ByF22gcqbZE1pTMPe4jKIgmSmtUNIlWH9VBTj?=
 =?us-ascii?Q?Kj0tvDSlCSIGbJkJ6uTI+oIV4xhcChUSAlD8+bePX96IrYCqP0W4hx1bWI++?=
 =?us-ascii?Q?zhtGb3AmU+w6bO5cVyaoTOCmxnA8o4M2UpSWxcY79CLvnqiV1O883rI7tCYC?=
 =?us-ascii?Q?HYXytYFGRhsPisf83FpnqWokkW51B0xIeFHVN/jMc8mgH+p1fAE7VMObAhg5?=
 =?us-ascii?Q?kgFYuDenh+U/A1cRbS10Ruz/3wTIpvt9aErzgByRcdmFVfGO5rkHyWWDUZQL?=
 =?us-ascii?Q?2i2Uc+/St/pokF1JJd4VIwi2Hhbs27EVjaWpIJgDTp+2fIgcCSBmlrrWZb0d?=
 =?us-ascii?Q?yjuAcy9F+mv7TCzLbBQa4yyjw02VmZ1XFB0Ynbw6GtJvtQ3glY9B5sJ6Bn/X?=
 =?us-ascii?Q?w5NgF/FJgIfLJwOx2IRj37Gng2/2C5HE61C8PGIPUeQdalft/BovRJgksx+n?=
 =?us-ascii?Q?rB7meP50tMm4I1O+pgOB++CJFBC4ieBIPwVPyooUxltQvzEnCi/KX00P3eez?=
 =?us-ascii?Q?Yh5Zmq6r64jde+x+NCYgIThgUi/dPQOzA9SqnPH9Db2aSDGlNp1qajbQCrO+?=
 =?us-ascii?Q?cUpZw0RMDNMSRo9pSvRuKiLZoOX6Pw5ZhR71XBNA24veeCuP+y/CzWiCPEk5?=
 =?us-ascii?Q?5YulU2tR/9a6dU02wcGLGJ9ffsOWv5HGsA0sfu3L0vK9HAIJAb0hMUEf3gaw?=
 =?us-ascii?Q?KSVMc3IsYfFJ0o1NcO+f2cLyZzVQY2woyTPkeiLtwtqTh0KchZvFdYjth6p7?=
 =?us-ascii?Q?XQZzoMWrILUC1uXIKZdzqR9pittat4B/q1fX32NEb8EF7XxmUCH6/R8XygCb?=
 =?us-ascii?Q?I3XcAsoYeC008EYoGhx7F+28M3cg14IRf7KU5XWqeWLNCSCB49lmW8hr/G9B?=
 =?us-ascii?Q?E+LCdFqUNqE0nyb8outqEtcXJ/iyozoZ5UkEO5ht+l3zG2zp0uBywvkUIUk9?=
 =?us-ascii?Q?aaq+agV8Bl307NVTDt8jiLkV1y2UcD4uiR3p4u++s584M1IrP3cjgdx5kS6a?=
 =?us-ascii?Q?zGHI8/QPu9PmlApv8WgPsJlbXeWrk2Kdu9ensQwg+bxd1o/hLcmQ80V58jQZ?=
 =?us-ascii?Q?XWIRgGfNSvzblpNjxo+5WJo7e6OTHrPXGW1hHo/N5D0UUBoK9zbyOOp/49b/?=
 =?us-ascii?Q?YLdoQzmoM+suJR/bzfthCWOrMgjtqcEMgt9JX92oeCHszo4dsjlibT6e3UX8?=
 =?us-ascii?Q?aeCHIF1AiW/1kuSfYGpHz1n8HzGghUjYgZdvn+6wIudBUASxeVYX6+uU7A1H?=
 =?us-ascii?Q?o6y6QE4n0QsWmPtaMO7OqHHBDkwEZ+bcuKGaZBMXNN8pZLzLdW0OwnZdlY/B?=
 =?us-ascii?Q?psPxqlKZwid69MIuNlqqegR8sF9XCzH7cAFaKmOj56J4m2yfRw44XSFoZFUA?=
 =?us-ascii?Q?3/ioLjAnLbcHupKc6Pc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc01065-ad7a-4ac1-1e72-08dbce38ff98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 11:14:00.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HI/N+k0rKs6Y3EJg3vmq8M0StuSC31tpb7OQnnBmEwmHFiS22fcrANDnqalQOuTyv7NrKhrKFbQInF7JV7QZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sure, will send rebased patch soon.

-----Original Message-----
From: Vinod Koul <vkoul@kernel.org>=20
Sent: Monday, October 16, 2023 4:39 PM
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: robh+dt@kernel.org; thierry.reding@gmail.com; Jonathan Hunter <jonathan=
h@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>; krzysztof.kozlowski+=
dt@linaro.org; dmaengine@vger.kernel.org; linux-tegra@vger.kernel.org; devi=
cetree@vger.kernel.org
Subject: Re: [PATCH V1 0/2] Support dma channel mask

External email: Use caution opening links or attachments


On 09-10-23, 12:05, Mohan Kumar wrote:
> To reserve the dma channel using dma-channel-mask property for Tegra=20
> platforms.
>
> Mohan Kumar (2):
>   dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>   dmaengine: tegra210-adma: Support dma-channel-mask property

This fails to apply for me, pls rebase

--
~Vinod
