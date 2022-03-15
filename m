Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E54DA204
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbiCOSID (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350990AbiCOSIB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 14:08:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779681402F
        for <dmaengine@vger.kernel.org>; Tue, 15 Mar 2022 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647367606; x=1678903606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WbrTVvVRHCsAL7kuCymIMW0/PS2fVzZ8eeMp9jhRtuE=;
  b=aiwY+7QERh8IWEVLOPLoWeibv80NtZ+G+JrxBBQuccPG7KxmNo+pj1mM
   kj4QtMRJNZsfsC8WNvjhWg/DGS/uc9cmemg00KZM+oF/iDZuOR3N9qwwN
   bWXdOrYBGcPkreFX1BBi89qNdZ9EI32Vn3SyLgh1Asp9ND/b7i04TO+aD
   pcDlEIQ2+lVpt57IoCcxOX6jw0QyZ3ECQWjKIBjkjExy8Ayg2+nR/VWcV
   Meo3FJU4Crn6rnPSO6PdMtQOdEoRBsUGnl3oUzX/YCXcVPIagBElkYZ+p
   ycU//jWEDF+sscE25S3PYnrjcJn/VEBRA52CG5k6QiK5p+pNzvl5Yjqt5
   g==;
X-IronPort-AV: E=Sophos;i="5.90,184,1643698800"; 
   d="scan'208";a="89019533"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2022 11:06:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Mar 2022 11:06:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 15 Mar 2022 11:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXsnBlxtQV3IeIkgEXq3/eRQONW3OBOStl5AG9Hi9WarTsWdvw3ywwBU8gCIiBZoTAeRPhPyEFdfd2yhAba9amQwfD0CDEMEOTXw+Ys8FsFKfRgjCRhXRzS0Si0pnsiDKVxJ5WLTVAGAV/uzW/ZLwmnBlfz+e2FsNZpfLQO4QHIkW6bt9qvCn1A85CG8bOxovKCZsXEMKpMcfH/ow3u+QhbTx6XZMYw9nVqDSK/dQbJPMXEySJXChC4WqecuOgZf1AgYHbb8NZAePIoYEyHpuKvJ4dbbssCfyN1xxOiLPTJiM+mbGAJOXPboiHwzFxr0mcA4crzSx1qfrG1XftS4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbrTVvVRHCsAL7kuCymIMW0/PS2fVzZ8eeMp9jhRtuE=;
 b=ncKiBuuyZPdHq3V8XIcsqZyYSpO6TI0Vp4/LLWbVTKFSAx9u1pfyttqyEiTeLDT9xYnPVjJ4oMhP6/YGNx0YpD07iX0vhdk/uP6imFv5Lgk6q0ZuvRsVVdkjWX2RWFoM4ZFS8od+x964yPoCSJaLdYt7ZaD5RA9f6Tnw9FBwf6VGEajBOAfzZ65Wor0BwH3BTEIq5wInFI9iDBRaoh6gkcm4GE9qZjHfhzAMg8luyW5F6AJPQXZ3A1lOf4WDnAwTKwh1hAmPMNtSlm9gh435U4EjIJYbe50cwd44hpwEkDWTx6+rj6PRllBs5ZTedyYBxTKhhhd6uKGLabyT1ZT+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbrTVvVRHCsAL7kuCymIMW0/PS2fVzZ8eeMp9jhRtuE=;
 b=dguhz9hbXJX9qr0Nx5pmNoob870cdUWM20yBpOPRL4YOn4atz6WhZzUb247uBluadEnzqaoyIPtS0ylOCA6DHT8tBSCOIBCQFmzBLzDckp6tvye2EYxQT9Ubl+TPdzjhwc6cNwnfjJGmSsM3JTBXAQEqMciEy3WqOgq2VVUwWDA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB3435.namprd11.prod.outlook.com (2603:10b6:5:68::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 18:06:32 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 18:06:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <benjamin.walker@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <okaya@kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH v3 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset,
 treat value as a single byte
Thread-Topic: [PATCH v3 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset,
 treat value as a single byte
Thread-Index: AQHYOJdmqKlNxH0mOUqb99ODAQDLWg==
Date:   Tue, 15 Mar 2022 18:06:32 +0000
Message-ID: <195385f9-73dc-6c76-a01d-918d5367ac4f@microchip.com>
References: <20220301182551.883474-1-benjamin.walker@intel.com>
 <20220301182551.883474-4-benjamin.walker@intel.com>
In-Reply-To: <20220301182551.883474-4-benjamin.walker@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0208e990-ad7c-4f71-4c23-08da06ae8934
x-ms-traffictypediagnostic: DM6PR11MB3435:EE_
x-microsoft-antispam-prvs: <DM6PR11MB343529920E2F7DFFBD6B9267F0109@DM6PR11MB3435.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GBRxNWKcqGrw54ObgUbhpj779WAmiadJKshQGjosP7HHK0GdpMjuSaVGXUSDZjwgE0SrjAqkQMAXWZWwqCw0p9T/cEtJODm9ZrMLxYWUwZHyVEJMHd/lECIq6hv724FRYPt/XNBJQIESv6l6+opIMNF0S+czLym95y4QwY+qjUdbICUAKpgeZ6C5JSxJGw8IUXcPIhreTBPAgM7VPjE1NbNEK14CYzzTmwMxmI8WLw8/W4nPgTHXn1d22MwTgF8O702qtZ/5vZXsbviKrq5NrvRL92ZYhll98LMptFFtOW+ZUmlbx+uA/i8aDkaDJlrSY6Dk81dG9H3nE5h4FS2CmWkianVRGwc79PObVEaYXqlgxnVVZxkgaX90i8P2jtob3+86rU1P6XqavBfCPg+HO5N3UhjWt7jofNIEfznE+CQUsv64E4BbmKc3FgHEQniqZ+IqSuKLFY8z4nOQoJOQfyzOZKbaSGRnaSUSswkWBdppG5GR/wTCPmlKyublmIy9hHOgLuHJeo+35lyYZaFNaqPt4rlVuccFjYh0cXBpv4AYwSiQu0aBYQIb/dYkAHRw6tHazdnoLGoJRUlI+e0hrBxB0Z8/iJ9sa06YAnEhd7gKCD2bQ3Hoa/0l5gRvEaRkvgggmz0xR2bEoNqjuEvW2Cj6qDZNPumRam16cAlgXVqomN8JVhfUf6jnpnzXXC1AbMvfrBHXi5NgcsS4egmZqNNHCOalUA6rCS+BlACFG74a5AlQzhkli5toUd0WUgKGd+gtyKlQHfMlstY2tiY/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(110136005)(54906003)(316002)(36756003)(26005)(31686004)(186003)(2616005)(5660300002)(2906002)(508600001)(38070700005)(8676002)(86362001)(31696002)(6486002)(6512007)(8936002)(6506007)(71200400001)(4326008)(122000001)(64756008)(66446008)(66476007)(66946007)(66556008)(76116006)(558084003)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZvM2xtbUdQN25MNnUrWVl1bFd6QmREa3FLN2l5KzQ2TUZpUklVU2pyN2xM?=
 =?utf-8?B?WGdLUGU3eHNrM2hDejBFNkZwWTVXS0dBSVFWZDFiY2NuakhvOXF5NmY2bjhT?=
 =?utf-8?B?bExEeWpiaWdzTkZUczI5RmRhOW5kbkJHS05qMmV3VGUxb1R5eG5iZ0x1THYv?=
 =?utf-8?B?RHBuUHpta0p4dVhEVzB4Q2VzbFhkcDZRbGJTQ2RodXo2cTJ5ZjBFZDU1K2U1?=
 =?utf-8?B?VENxUEFSZnROZFJqcms3SDBrYk1DeE9BaGRaSVpac3RHd3pEbHpXVUYwQ1pY?=
 =?utf-8?B?WXd6eDUwajMwMS9lMjMzbTlTb1lCVlYxaG1iWmUyYzI3RW01SkV4MjYxRVJ4?=
 =?utf-8?B?dFdZeFN4TGRjS2doQVR0TG5wWDFnd0xkZFgrNThvU1Nob2JkRFZ5QlBTeHZs?=
 =?utf-8?B?Ums4QXVsS0hwb2VsTE1NNXpTN0ZsZU50Y3U5UlFGcmpWREtlbCtiNnVlUFdv?=
 =?utf-8?B?L3dWTmoxZkl4L2FncDJPTE95d2ZlSXp0dnJpdURocXI4Y3ZodElLcEtocnNC?=
 =?utf-8?B?amJZWEVHMHhPd0dOSVVDRlE4NlQ2NzVwZXBxdnhJUnB2cVJQL1F0cFBObndp?=
 =?utf-8?B?VkRhT2ZlZ0NBWGtlY3RhRzFsMytSRE4rOE9TQ2t0dDJQZUQyT3lRdndsN3VL?=
 =?utf-8?B?dW00YVhiNXkzdjM4UTVJdUI4bVg0dUJ3WUJsVmxjZlR2Q2VTVFJOYWZHbFc4?=
 =?utf-8?B?RUd3UTVhUmVmbGE3WWd3WEllaE1SYm5INU5ZenQzeVFqSFNYR0o5NzlXRTlv?=
 =?utf-8?B?ZWhDUGEwVXFVNHU4M1Y0Y2NjWFNCWmNhcitJVEVnR3ZmOTBFV2djNU9aK0k0?=
 =?utf-8?B?WGZWYUp0L0ZmZTVFVWZhQktwNnZFbXI3QnN5M3pZOWM3dVdyWVVxbllTUDBq?=
 =?utf-8?B?NHJqUnBkZWxFQlNMMzBPYU9vQ2lwUDVrb296U1ZheCtvU0NMeGdKaUR6alVK?=
 =?utf-8?B?eStPdEJVbnV6cDRrS1lOVk9URVFEU1F0WHNQbTlHR2JFS05wSitsS25Md291?=
 =?utf-8?B?WS8yb0hiL283Sm9Pa2U0TFRHUnlvZUx5bmZ5cmVscEhkQi94RnRZTVJXQnJh?=
 =?utf-8?B?RlFYNkdRYWdPOWNtbDIvOHdyTXZoSUtHU1FQTGJGL1dOczFTMG1QekdTeVVC?=
 =?utf-8?B?ZjR4LzgwaXV4UGJPU1BySzVjNGxqNWg5c0xvU2NENjY5ZTEwM0VCVTdXaGk1?=
 =?utf-8?B?bllmZzVYVkU0NHl4YjFJb3JSdHR5dVpPQ0IyTGJISHV3SkROTHZyekE4b05u?=
 =?utf-8?B?a1ZvQkRHdTlkNEVsZDBlbjRtTjNzSWIzUmxlZHU3dlVMRDNGT0QrWFBHSXdJ?=
 =?utf-8?B?aWxrcHdEZDRUT2tnWkU4TTJNdE5hdHFTY212dCs1b3l2QWFqd3BiQ2N5dmc5?=
 =?utf-8?B?SS9zK00wcjA4ZEpsdm50aEd5cURTVENCREh0NUUvU01NZXZHbC96Y1Fna0hm?=
 =?utf-8?B?Zmhwd2x4MmFabmVwbzM5dmJwa1pRaENMVG9KaXlOQUxmd0RyVzdZTnVOamJL?=
 =?utf-8?B?V0JoZ3ZSTGUwemlCZU1zVHVtdFloalRmbmNKVDgxTncxbE41YW5FNzhhQkJY?=
 =?utf-8?B?aUwwNm1jWU9WWG9BNGF4VTVTdlJPdGs4aFJnZ0Q3VnFxRy93ajJPMy9WM09s?=
 =?utf-8?B?b1hyVGdMZytsckNHY1VndHo0Q1Z2M1dqbVAxdkFzLzdtNlptZTVvM1F3dWc0?=
 =?utf-8?B?N2tiSG1mQ2ZrQ3haZ1hsYVdNd2xrZ2JtTGd3OUNEMVcvYkxzblRKdTVMck56?=
 =?utf-8?B?YzVlZTVDYlY0WnFKMUg0dWtBSnhLdWlVZjVFVHYzZFZBUWhuUWVUY3F6TVpR?=
 =?utf-8?B?a1lXaGF3OFZKbitLUFlpU1ZOa3BPSUtzeUNvZklNdStRZDBuZDAzQzBTR2cw?=
 =?utf-8?B?RUtEY3ZGQ2FaWVlSai8vcTVuUTROUWRiZ0hEeWZIelFGRTdHdllERVA0bVpk?=
 =?utf-8?B?MWtLTkc2bThHdDJkMm1FNVd6MWZPRXhhQXBJL3hHdjlVc21Gdjc2elNabWsy?=
 =?utf-8?B?TTNmVXI1L0J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09F0D937E7DB6C4FB0E118BFA04DF3D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0208e990-ad7c-4f71-4c23-08da06ae8934
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 18:06:32.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlDlGAGGTjX3Mj1nnX4NprIr+z8Et4kFkqGwR7qYrO3fhC51tzifqXzPKxkMLTYEBpKXahkKBcCoBySHH5Jv6G603C2XetxrYJcZ3mQo5Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3435
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheS4NCkp1c3Qgd2FudGVkIHRvIGluZm9ybSB5b3UgdGhhdCBJIHBs
YW4gdG8gdGVzdCB0aGlzIHBhdGNoIHNldCB0aGlzIHdlZWsuDQoNCkNoZWVycywNCnRhDQo=
