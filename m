Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3560C7A7
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJYJNp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiJYJNa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:13:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D3160EC1;
        Tue, 25 Oct 2022 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688828; x=1698224828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lfUxlPOrPnnvzOqIw9HGj2AmAt933JZqfsH5LLT3AAY=;
  b=pH8sjiWcS0j4bWFbvPE3HX77v97zgWQnR4h07m3/o+CO9EuUwiI6/Uzg
   mS3Bam6bGs/oag+9fVc2dN09YdUOoUN/5NVuxFaEBwUr53KN903AZmoLp
   qhonW1UUHeYBTOqEa6Ief1yN0xwbA9gDl8JLqKANjlcGnUkwOFJq10bYV
   vKl1d2Vj7Tm/stfy121nS8I93zfjjmMdMnboqbsgMrcXB5/vlXvOXXI60
   480cPJDL9ClzRg6Czd5vlTSUHyFTBGWEP9e9qJwKAKQu2uIpW9E7uhCeE
   lxrxYIlynARKBChMChg2QgbZpsc9s/0A9eI+w5yg2S4LwroTPUYr/OBCY
   w==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910546"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:06:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:06:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 25 Oct 2022 02:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2lYm61vgbflMnfX3+qtwKVXJSECjM33JFYUSw5hs666N5aCdCrksd/em6FI3LhM6OZMbkX163r/TE9gajq5o16uOPl92Y/3sE8XPXqtyTTN233wUOfs7CrgEpN+OBSttlfIXt2AnWpC/cHilsLPdtatLu3ML2vzA/sHmmsO1T0456o2KRC8HL7n+Aev06Wr3zbtq4AD1zVtwpzWtJBqss4UpUGBvtzlwTY1TD9qsaImF2uRT0ZifY7J2H6Ik91Am6PFYAh4tu63SPBWWIhwjBz5shbP5dqZLMVKs6ALcWeAA5nmMWzHcI7faVs8FzdCCDgBH32fcRgyh4M2dqtY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfUxlPOrPnnvzOqIw9HGj2AmAt933JZqfsH5LLT3AAY=;
 b=KhT/bnCTZBZapdCeELvjYH8McgU757zjq4zmuC+4k2uyNNnCDoxHRBAy0kxZGFrCjyjy24HFthsbFtEFN7PWIbUjq9VbxydCUkVQ/PuoyUgMU4NzSUzkAYOVlmBdOHRuaegwYuhxux8zxPOVnTHekTDtSRyCjgK4Euk0/Yx/cO8VNkKDI0kh0wzZ9FqvHxV623cpEpjO/kPhVVAAX4ukeTS6Liaa2iMehi7dgNv9NugArtQH1agV+NvIr0gzZNhBy6KfHpYUX3r28vX9rOZeBh5/mpxMi0cYsMhjOFy84+kxNGY/PwwiqjvprX7eC/wQSakmFAimPyWv/wj1ElwyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfUxlPOrPnnvzOqIw9HGj2AmAt933JZqfsH5LLT3AAY=;
 b=ZT7JQjP9crAJ2vVeSb8+gjbn2/HjHicj63gzm9nbsBnno0P5b9k5v3U3Q5wyaxk9gnvQyODzhiXllarMK2z95EEkIuHrrT6VUmNNev+0DKqXXFidXhT7nF3VbpHC3yPmKB25d8oc3mlu6aeBTieVTVtftiZ37rHqCS5CyUkmhi8=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH0PR11MB4918.namprd11.prod.outlook.com (2603:10b6:510:31::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Tue, 25 Oct 2022 09:06:41 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9%7]) with mapi id 15.20.5723.032; Tue, 25 Oct 2022
 09:06:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <Nicolas.Ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Thread-Topic: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Thread-Index: AQHY6FEYL57d78lf2Ea0R6kPIjrAlw==
Date:   Tue, 25 Oct 2022 09:06:40 +0000
Message-ID: <01ed2a80-457d-c765-84ac-d5753a2b810b@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|PH0PR11MB4918:EE_
x-ms-office365-filtering-correlation-id: f3c0e503-14b2-4df3-363a-08dab6683b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5DOQe1/92gDgODFaIn+iutO/9CtdW9q8viywBoGhzckTAjatoYNrB6EXg3k/WIMpGN1oHwgF+cXMHPV1Ebs87fh0ErO2DpZQC53G+XQIwKAHEPDzLOUgZ9hxU1khoMrHgPlV/pgjWIXO5WHUs7PL+r6TdCFdgIaCQ8gcXT/x1jOV4gbgOa+Dp80dE1lJQf/8pkxuyMDFQ3epsefKylYHQvJ02eK3FYw0+9wNMBx/o9AidFeK4YXRZyYVm13kCwvWNSM6j+5nYGGQG4a+q+8XCp4NzbYF2dVRLplhCLjv2HORNN09P2LiiNEo1fRttS/swJnPSe3mwaYTVtx3vrebY27OCXUFOMAzE+u9TYZJkiSoko84Yca3dmSBKv4CMOaQ4UO/WSCYjPimiNBcwYelNsYI/Rwn2CYgnShtusAuHqTfzKvADYk4eL79MWrEzFNAQF7txrNXC7LrSvs2nEkGlNR71N8bpdHVYgW7IAxlYX8nxXI3cnFKoziHvjpsIUybWaz4uVuZrEo+YTb87virHH1uq7B7fkEs2tdWuItQHhwx+IKmh51B+/FNLjPAhb7dCXoTx6JkPSqrZIXrPI2KCUydi0ldMFvvoKLupq+4rviRLixlHXx2bvkIcjCzApLogbxos7QUNSAvfiP3mNnDd487PTciyui9FsYidrJbmzJ7duTPyC0uMVeN0FnCVmK7p3/A2uxqHvZg8/kRkXppZLK0yfobckQQHD/WoEQ1ujBzXBLsNz3HzqwH4kXjrl+edaUExzbmi71a27v2qTn3CT1VxQagvrU6C+4bCX5U+SRHq4VA6efDOeE9PqC/pAqHL6C0OQ25OWR1KQvWajDaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(66476007)(38070700005)(86362001)(66446008)(558084003)(31696002)(122000001)(38100700002)(66946007)(76116006)(8936002)(66556008)(5660300002)(4326008)(41300700001)(2906002)(91956017)(6506007)(8676002)(26005)(2616005)(6486002)(6512007)(110136005)(54906003)(316002)(478600001)(64756008)(71200400001)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xlR2ZWWU9UUXJlTEsxd2xZR3Q5d3FBTi92THlYcDlmKzF1UStCYWk1c0NI?=
 =?utf-8?B?dHpuNHNPMmF2dnV4VVFIMXZmSWNnS0xsWHhsOHlXZTQwdTBvSjZNaC82cHNs?=
 =?utf-8?B?N2N4VW81UkF1TjZEMXF4bnU4aWJtWmhDU0NpTzhKSHdnU3QvSm1Nc0R3VnpS?=
 =?utf-8?B?K1NqKzVza1hjL1lwTHJieUtwejJKOUpuWXozWDdKVXgzK1BXRFEzb3c0b0Yr?=
 =?utf-8?B?emFkdUVDUFVyR0xTSTFBbzBHRmhoRG8vd1N2Um1TVit5cFRPbWRSWmNPTStv?=
 =?utf-8?B?WDJjUFExSGpRQlRaWHNSSDZnYWNXM3RJUjhtdWxOSnNUUVhEMGNMWHp4MUpB?=
 =?utf-8?B?NDRUWXFTVHZjVjRxYWRCbU1DNk55WEl1RTVMMGRkMjJMUlVqdGpQTG56TnEv?=
 =?utf-8?B?UWYyWmZoNlJjZmRxeS9HWXRmRGZTSWk4TC9LLyt0WXN4YjdDK2JHNHRUOTdZ?=
 =?utf-8?B?MmdUZGIrekdFNmE4NVYxUDJpMldUbFRVcmRIdkhjVldtTG9jVnd1UVNGU1Qy?=
 =?utf-8?B?VFdFcHZlcUpsUEFKblhhSXJtTnp4V0hvZWhPS2dWNU1FTFlnRkdFZFZNZ0tE?=
 =?utf-8?B?SFJzVmVPamhJelVkT3l3V0poejB0YkNoYzQ2TGFYU1lJSno0S2NWejBpRTVv?=
 =?utf-8?B?K2J0THBDTVVFYWx2TGlkN0ZLME9qdzgvR2VOckEycWJLdzk0SmV4M1p0Zmdh?=
 =?utf-8?B?c05YeEJFZUtTSDBNY0N0a2VBaFlaM3dHbit5Umt4TUZhRE82c0lqNzFPVFA1?=
 =?utf-8?B?WEZNL3VnVFFISVkxWWQ5QVljYTRHdFY0dzRtOHJ3SXcrU3ZhS05ad1FVSzZv?=
 =?utf-8?B?Ukx6WlZqQ0ZVSFo4WERiazBNWkg5aG9qMytHK2xQeHk4ZFNtR0t2bVBGZ0E2?=
 =?utf-8?B?Vmd2R1pPK1htcGdWK3phSzZaYnU0dnZsUFdqTFpsS2VEYUlxMnlyN21qZkpE?=
 =?utf-8?B?elFUZ00vVW1sUzBhRG5HR0xXNXRZQXFKamNodU1uZ0pHaXpJMlpDakIyOWNz?=
 =?utf-8?B?K2NVVFYvcUhOLzRBTVhTTDJaekUyaFpyU0JLcWpXSEMvRHl2S2dqQ0E0ZHJS?=
 =?utf-8?B?TTVaMVpPQUZZeTdlaHdxZFAvbHN6Skx6dmpqVitSejdLVHlndnZ3SWgyMFZV?=
 =?utf-8?B?OFZMRSthbzBmNExYOEFvR2tpU3h6TGlMVHJuQWxBU0FYTjd0STBpbnB0Ni9D?=
 =?utf-8?B?ZzFrbzRPR1pvRmVRV3p4Z0ZGeWNsMWtBRzNndjIyL29OTlhYZGxwdjZqd2Rn?=
 =?utf-8?B?VWp1eGpvbjM2a1VUZ2NRTW1nTlhpa0xZcTZWbkZmVG9YdTYrY1JxNUsvb1M0?=
 =?utf-8?B?ZVhOR1NYMUtHdEN6WndEdTVzYUMzOWkzQ1htNDRONzZoK0NmbFErRTBLWWVz?=
 =?utf-8?B?UWI3YkxXU0UrMkRaR1FTajhGcTY5Uk9XR0hEcExIc242OW1DVXNITkRDZ3l3?=
 =?utf-8?B?TWRFS3VBSnd2N0RRQ00vc015ZFg5NGVJUDBIeGNDc1p1VGdKdzh4RHZLZStJ?=
 =?utf-8?B?L1p0UHVuVE5JSjg4aEJRSU9yaURvZi9hOFkzajZvMzk2YVhYZ1dpYkRqTDdM?=
 =?utf-8?B?YkJvczZmUEcrQkRpY1VoSnNsRjhaQXBKL0JmUyttN0J2bmszMEYvSExNbk11?=
 =?utf-8?B?ZlBwTERjL0M3UmJuZ01qZzZNUHFlQVlZVTJBWWRoMmxpYWt0TzM4QXRKQStD?=
 =?utf-8?B?WjlJbmVKQlVsOVhuYU9ERkUwRUFqakZ5WmswdndvbVljbUFraytjd3VMRm5Q?=
 =?utf-8?B?K3pYVjUxNzBYcWM5dTI2eTIrczVqRXNqSkQ5aFlHaWJPTlgrZ0NNYUNBdXNP?=
 =?utf-8?B?YkZBd3NucTV4cUwxeG1MU2lIcUlqRUtmems3MHF2RksrMnowNXdxT255YTRs?=
 =?utf-8?B?ZytYZHRMeEREOWYxVk9rZHljeUU1ZFQ2cFFrLzZTMEVTdkZyR0tvdTZpem9a?=
 =?utf-8?B?L09JbGNHalJPREFVN0tIdjFPdTMwN2dvcE03TnhpZytnOXVBNEtUWnNLNmR6?=
 =?utf-8?B?QnQ0TTlhMVJaMVl2RDF2RkVBR1VHQkNQa0NRb2tDNEpZSEtZTHgreldjdW1q?=
 =?utf-8?B?Q2FveHo0aURMeU1qZFhGVk1OSDFqRWxhbjE1c2pMRWcyQmpzTFRUWmk2UTBu?=
 =?utf-8?B?QUNleEdvSURtUnphaW05SjRFczNHTFAyN2FQbWpUdnNabHp4eUk4UEFuTThs?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9607EF3B731CC149936691D3EC8EA47B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0e503-14b2-4df3-363a-08dab6683b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 09:06:41.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVZufcSmFlPP/pXj+fwfOrW86UuKVetVuNCelozW0Iky/HgAMUI/KQWNucNfve16+UjbdebJmiYy+ztMRvnPlPcs4I3w0QVZDEZKwPcTR0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4918
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIFBldGVyLA0KDQpDYW4gSSBoYXZlIHlvdXIgdGVzdGVkLWJ5IHRhZyBvbiB0aGlzIHBhdGNo
IHNldCBwbGVhc2U/DQoNClRoYW5rcywNCnRhDQo=
