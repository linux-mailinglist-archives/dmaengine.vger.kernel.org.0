Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888F620F82
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiKHLu2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiKHLu1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 06:50:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51802FFF8;
        Tue,  8 Nov 2022 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667908227; x=1699444227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jx2KLLzoKbTNuX1ucXzMoZ+WrAobdXiE4gb2cm6y08o=;
  b=l1gMO2RgaS3EZnp/chJGeyy5rjNPbnFp/Od6f2x+oon66fGrH1oM05e0
   lhyAgqu741j8Z44yaVImaPmnDXPdV9PTgIiNli5JfMhkXwVFYMkHJ3a+S
   kBtRzvWGaNfCSYCYkNgpjJor1K7j8e43xxHVuIfguBxiJiekpk+77ScNb
   ox9bUf12fpRpqThJyGej162xAWeu9n9+BIhJQBTK4VjtSB6wfDy8JKPJg
   bT3xS5Rfi372GTQx6ZSXO69513omzoj03jILyHHp6nXBZ4YVGDW6BdS+W
   vFm23i2kGjRaJioZEbZPJUP6hORtBvVON0EYm/iDnt8t37Br2Mg4NNZt6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="182451026"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 04:50:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 04:50:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 8 Nov 2022 04:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsiI8NC3X+DZAtRAkg9G+JuukUQNguEK5mdPC991UKwzFDjdrC0L+QKJMQgdCKaeGjhWIhoI3X/ttEIv2rUygx2ega+T8pkNz6PeTzo4dMWzSkgVTT7SlL1orchOS7ks4bnh7/WRp0AKQ4Aw3ATFWKlpCgpE+kc72rBXI2djTLA56RKLJYaC0tL4KWXB6TNqVXY2LUeCvZ0dbMfQIgV8JCQYVyJFLyM9XjQ3tO4yfmnbMWFirsXou3OMmec6oHOOrRbE/fjBSCELtEyW5zDzuDtqLqTVmSS6WUPq30fx7VyJ8lVU+xOKnDoCI/fOvLLsdBPA7V56DWQArDbY2iFcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx2KLLzoKbTNuX1ucXzMoZ+WrAobdXiE4gb2cm6y08o=;
 b=POOeGihNWvnjqX3gz6BllIo7dmTavG4Ory/hrWzLV583QjHDkYeZbWkYPHjXfaGADEkDPQPMma0CMqlMlVAvbmseEbbnlg1JvzbQyF7kGKOnE9UabhKh8mwAsK150BbJQSAMb6MYN9A4k5TMrzp54Sb5TYZusPeQrK83Juz+sbunMXz26AtgM7EvowmVQub3VBiqO6xm60AwsqCCMETGCEccXgKsnZFfu6RNzDTj5vHxuPOeZm94tzoZ0In9YsJB+eAnbasRIycEgmNlplRz1Q8UE0dsgZxtaYnG6S6GQJIypNalEwWqOZFddVM/lP5SRaoNHyL/Z4ZD1A08W5POPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx2KLLzoKbTNuX1ucXzMoZ+WrAobdXiE4gb2cm6y08o=;
 b=Q4OxH/pKVuBFPhsRW+sMq89F61wXJPipe+gcZa9unH5TYeLEzjuhuvK1B2a6wIn6LSPXWRNCmmDF8SdhJpZ0wbTIpVbfMGP+BgPLalqitEnz5LotpqN8yFzi9MMLO71abSgfmbFdtA0m+9NZU8zxjPE+yqmC1ecGsUAkmNmYidQ=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 11:50:19 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 11:50:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>, <vkoul@kernel.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v1 1/2] at_hdmac: check and return DMA_PAUSED status when
 suitable
Thread-Topic: [PATCH v1 1/2] at_hdmac: check and return DMA_PAUSED status when
 suitable
Thread-Index: AQHY82hFzW85jqitHkOJydgzfw6xhA==
Date:   Tue, 8 Nov 2022 11:50:19 +0000
Message-ID: <d3d93452-70e6-72e5-b28e-1b259d1e489c@microchip.com>
References: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|CH0PR11MB5220:EE_
x-ms-office365-filtering-correlation-id: 3d1f20a6-1642-4e6e-4e61-08dac17f6939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ar93qJeqFzIIrWcpQnjM0wZB9WwrihZqH3NvMyueeCpkH7xQ1+nzlPM/O1+H58ve5XUMPaXYcQNl6x8NXWg4Ta0r0XLA7eOGx2O427HzEa5e8B19ZyALCF5UgQ6ZL8GyRyvBwH5CScY6HJt0tERhNlLM90vZ4eg1EtVRNrB34fzoV+plGdIIUGNcOFWfyulRerhDig3wzom4NTPPFnA1H7hgYt4r28e+MuRaCSCmwB+qJtLxEKX14vQdAPHPmOWBLvCbt7qjHJLzju5R9fSxQSCU48vS5yO3ivP62Uy0qyntRreVGH6fuTX+rfNrXwFdQNMFl2Uyj24YLLCIOJFm9gIEk3vYA/v4x5IVcVyqK8Ec2bOkzkcgCnOeyhaRE7IDBkUzi22aBoAvxrQxYizEIizEM8gMRSZzlyjxMvkDbfR6DJBZBbx4wl4LP3NxfYX9Su7ibo9gSqKx1ACHDhwle65tSfy3ia5KSDAKiec9Yz07Gsar6QljOWdDuEdBeqZbj64wZoxA1yQQIQZ4dIbddCJHdMOGSus3VjSwnUINUWD9It/dR+3eFsvdqanNbK/OHZuEeroTV+arSBI+N7GzeddKO7GcqT3wMb9fGNo+RfOqE2U97DkSYzqppOBUo1Z0pW6HAx+gR5TkZOv3CwkJmBcVjfcDl+X3QfIElGqO7uqESLXINsOM9Uj7JqrtF3R9ZPcRzHd4KlPed7etfq9Uqr2051pW+Wv1c6LyObdczjrEBZYYZ79DjAEF3Y9ZCCg93ynDEzDJg1yfJu5uxMRldh1FYY/IGBvq/phmRQRkZ6uTq8G6zIgZ6qhUYv98eRr88UEv08Ppncsz1KVCtQ6ruA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(36756003)(31686004)(38070700005)(31696002)(86362001)(83380400001)(2906002)(186003)(26005)(6512007)(53546011)(38100700002)(107886003)(6506007)(122000001)(66446008)(66946007)(66476007)(4326008)(64756008)(8676002)(66556008)(2616005)(316002)(110136005)(76116006)(91956017)(8936002)(6486002)(478600001)(71200400001)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFd6NGdFeldkcGFuU3MrakUwc285ajJzTGxBRWZ3VnQ3VHBoMzNaa05BNTZN?=
 =?utf-8?B?ZVc3VzhkREVMd2ZjQTJza3M5VGFtN1UyYW53UXI2QjVXcVFySWQ2TTk1cllJ?=
 =?utf-8?B?Ris5OTk3ZFhJTVhBQVc0UDFFaEE2Q2xSNTA0bml4akVRRSs0OTNCSEYwakw1?=
 =?utf-8?B?bFNnNDBDVkNPNkNpYjVkdnpoWDF0NVAxMlZoMjkwbi9ueEJPakdwbkJRSXlu?=
 =?utf-8?B?WTQ4NmNmaitFeStheDN1UE9qWXczU245czcvTWdFYnk4ejYwUE9seE9VcVcw?=
 =?utf-8?B?K0U2MWpnTmFSWWIvWG5wV205dEVheHpoWTk5bmxCMTBvMFVxM1hPM25DVlpU?=
 =?utf-8?B?MUpKKzdtSGdadGltRStkcFRXNkc5SDIxd05vWW9MejBkaUNscnJEQnM0aTRH?=
 =?utf-8?B?c0VUSmlzSUNQTFpKMGFWWlgxVWExblBGZUp1TElieTlyRFBLVzBTckFFSUky?=
 =?utf-8?B?RlBiMUlHWVVZYzZHT0xFekcrd1lXVUF1bUxNb281TmFWSUJyZ0RaM1FjcGoz?=
 =?utf-8?B?bzR0OG53b3ZVYjFUaVNsTFZHNVFTRFZFS3RFbWVMdGp1dlVaUHBKVGNpckF5?=
 =?utf-8?B?UDlvK0M5Zld5R1JBdjZWTlVhcFBzY0JEUFI1VXE3eVZpQlZ0ZHJ1MzhVeXp1?=
 =?utf-8?B?RUtDd2FpalQyNU5lNnZpUUlsUjVrcmU3WVM1R0wwVjBwbGg5Yi93TVg5Qmpl?=
 =?utf-8?B?VmhGZWJQci9qVGZPRGFlTHhETFJDLytqcytXd3lBbmxnK0JoUm9hNWpGOEFs?=
 =?utf-8?B?SklmZk9tKytLYlRyTC92ZnFCRitNU3piTnJiSEt6Z1VHSWErZ0ZiRmM4K1Bi?=
 =?utf-8?B?SGVHZjdEclJvVlY2akttcjM5a2NvejRDWWlSbERncmRjUWovTGN5T0UwTUNt?=
 =?utf-8?B?ZllXVHF6ei85YTNHcGd4WjdQS2orbnlibVNTN0RIZzBWc1B0cGdCckxuaHFq?=
 =?utf-8?B?Q2dsWm1xbDRCVnBXV1NLTlB6ZnE0aE1wcjM0KzhiRWpUSUE5RmRFVDNhdm5Y?=
 =?utf-8?B?NHFtK25RNmdDQjZDYWhsdUhKZjlCbkp6V3dabXQrWEpKRG03dnFnWnJDR3ly?=
 =?utf-8?B?MGtjWi9IcnJUeFNwczRZSm9TbTUvRXdTY0tSaXhIN3VxdW13NVBNRXJQQkNW?=
 =?utf-8?B?MUpFLzh3SmU5bS9UOWt3QUhYbzc4cEJ6WUpXdUpZSDkzWHppdFNoc2pwS3Qx?=
 =?utf-8?B?MFVqaXZnS3lBdUZNVWpVbVRxMXZGTTJKSGt1UjlmdmgzcjlQVXdCSmVWY280?=
 =?utf-8?B?ZzRJV1gvOG5KUi9UU2dhNmpNNFhNVlAyQTRzOWw2VXEzb01WdmdLczJ5L0lN?=
 =?utf-8?B?N0pOTnpxNGRnNGU1MkdMSGZCdVRCL2NwRWN1cE9sUnJqeTRkVWE5akJNcnNx?=
 =?utf-8?B?OUZUdWMzZVdMWW1maWtyOE1BekQ3ckRWK053OUJPR20rS2p5OGZzdlJwMUVh?=
 =?utf-8?B?NE9XQ0RrL1hXMnB3bHN0LzYvRDV3Wnh0QncxVVZ3c3lvdW9zKzM4Rk16Smtz?=
 =?utf-8?B?SWpTRGJBcEpvcWFZN3dsRGE4VnVYUm90RjhTTHNjWEdRY1VVckxTL2tkanZh?=
 =?utf-8?B?QWprbnNPK3kvUWZTKytuL3Fvc295dUp3ZnU2VGJVMmNLakdBeWhzbnJvR3or?=
 =?utf-8?B?VGxYay9HcHJnYkRLaEdQVi9CUDBuUFZaTFo0c3N4cElTeFpYRE5ZcWNFSmxs?=
 =?utf-8?B?TkFyQXJLUEtkTVNVNGJYemVweXdIMHcrVmNWRUlFeUxpQ1NDcmNjTnp4dVp4?=
 =?utf-8?B?NkhpRUQ3cEtJaG5hdHp6ZU41b2l0NVFXM3l6WEpOcFg0dWlSQWYrdDBZZ2V6?=
 =?utf-8?B?ZGsrZ3Qzd1ZYOXBlQW1SKzNVcW5meXIyNlRycFo2RjFYZUlXZ2ZyZnVKL1hY?=
 =?utf-8?B?b3NqaWVRK0N6czNIQVJBUjdLVG5OWFk3WkV1eVNVOSs3bFhjbUlyVGlkK0ox?=
 =?utf-8?B?bWRkN0UwMVd0YTNWUHRRNGQ0eGtaV05FcWlLWW1UYzFsR1lLZ1Bld3IwVk5W?=
 =?utf-8?B?OWd0ZStOdFVhNE1vKzVhSU5TdUU3cXlXMFBnNGN2THJObDhQaW50Q0dBZ2x2?=
 =?utf-8?B?dXlWYVVueEVwRjArcitEYVJsejVya2pJR0RyMzZQZHFMYk1JWW02WDRxbS92?=
 =?utf-8?B?bDhjOE1GaGJodUlXaC9Xay9mWXNYTVBGTmdUY1lwSVhVV2tJRVhvM0cybkcw?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C41CAA309B314D8B23718BCFE72736@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1f20a6-1642-4e6e-4e61-08dac17f6939
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 11:50:19.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6Q87SxEiqstxa772WaBV8NQvwo6hDaHtikfGAgUJfRkrUWB0/72BwWBruH3bCQT6/8VWLq0cj4VY/SN78hKESfFGRoSgVFfpURc9Uh6sg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIEFuZHksDQoNCk9uIDExLzgvMjIgMDk6NDksIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBkZXZpY2VfdHhfc3RhdHVz
KCkgbWF5IHJldHVybiBETUFfUEFVU0VEIHN0YXR1cyB3aGVuIGRyaXZlciBzdXBwb3J0cyBpdC4N
Cg0KWWVhaCwgYnV0IHlvdSBoYXZlbid0IGRlc2NyaWJlZCB0aGUgd2h5LiBBbmQgdGhhdCdzIGJl
Y2F1c2UgZG1hX2Nvb2tpZV9zdGF0dXMoKQ0KY3VycmVudGx5IGNvbnNpZGVycyBqdXN0IERNQV9D
T01QTEVURSBhbmQgRE1BX0lOX1BST0dSRVNTIGZvciB0aGUgc3RhdHVzIG9mIHRoZQ0KY29va2ll
LCBzbyB0aGUgY29udHJvbGxlciBkcml2ZXJzIGFyZSBmb3JjZWQgdG8gcXVlcnkgdGhlIERNQV9Q
QVVTRUQgc3RhdGUNCnRoZW1zZWx2ZXMuDQoNCkFsc28sIEkgbm90aWNlZCB0aGF0IFZpbm9kIHBy
ZWZlcnMgdGhhdCB5b3UgdXNlIHRoZSBmdWxsIHBhcmFncmFwaCBpbiB0aGUgY29tbWl0DQptZXNz
YWdlLCBhbmQgbm90IGEgY29udGludWF0aW9uIG9mIHRoZSBwYXRjaCB0aXRsZSwgc28geW91IG1h
eSB3YW50IHRvIHJld29yZA0KdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9hdF9oZG1hYy5jIHwgMTUgKysrKysrKysrKysrKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMgYi9kcml2ZXJzL2RtYS9hdF9oZG1h
Yy5jDQo+IGluZGV4IDg4NTg0NzAyNDZlMS4uYTlkOGRkOTkwZDZlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2RtYS9hdF9oZG1hYy5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMNCj4g
QEAgLTE2NjksOSArMTY2OSwxOSBAQCBhdGNfdHhfc3RhdHVzKHN0cnVjdCBkbWFfY2hhbiAqY2hh
biwNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gICAgICAgICBkbWFfc3RhdHVzID0gZG1hX2Nv
b2tpZV9zdGF0dXMoY2hhbiwgY29va2llLCB0eHN0YXRlKTsNCj4gLSAgICAgICBpZiAoZG1hX3N0
YXR1cyA9PSBETUFfQ09NUExFVEUgfHwgIXR4c3RhdGUpDQo+ICsgICAgICAgaWYgKGRtYV9zdGF0
dXMgPT0gRE1BX0NPTVBMRVRFKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGRtYV9zdGF0dXM7
DQo+IA0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogVGhlcmUncyBubyBwb2ludCBpbiBjYWxj
dWxhdGluZyB0aGUgcmVzaWR1ZSBpZiB0aGVyZSdzDQo+ICsgICAgICAgICogbm8gdHhzdGF0ZSB0
byBzdG9yZSB0aGUgdmFsdWUuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKCF0eHN0YXRl
KSB7DQo+ICsgICAgICAgICAgICAgICBpZiAodGVzdF9iaXQoQVRDX0lTX1BBVVNFRCwgJmF0Y2hh
bi0+c3RhdHVzKSkNCg0KdGhlcmUncyBhIGhlbHBlciBmdW5jdGlvbiB0aGF0IHlvdSBjYW4gdXNl
IGluc3RlYWQ6IGF0Y19jaGFuX2lzX3BhdXNlZCgpDQoNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIERNQV9QQVVTRUQ7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gRE1BX0VSUk9S
Ow0KDQpyZXR1cm4gZG1hX3N0YXR1cyBwbGVhc2UNCg0KPiArICAgICAgIH0NCj4gKw0KPiAgICAg
ICAgIHNwaW5fbG9ja19pcnFzYXZlKCZhdGNoYW4tPnZjLmxvY2ssIGZsYWdzKTsNCj4gICAgICAg
ICAvKiAgR2V0IG51bWJlciBvZiBieXRlcyBsZWZ0IGluIHRoZSBhY3RpdmUgdHJhbnNhY3Rpb25z
ICovDQo+ICAgICAgICAgcmV0ID0gYXRjX2dldF9yZXNpZHVlKGNoYW4sIGNvb2tpZSwgJnJlc2lk
dWUpOw0KPiBAQCAtMTY4NCw2ICsxNjk0LDkgQEAgYXRjX3R4X3N0YXR1cyhzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4sDQo+ICAgICAgICAgICAgICAgICBkbWFfc2V0X3Jlc2lkdWUodHhzdGF0ZSwgcmVz
aWR1ZSk7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICBpZiAodGVzdF9iaXQoQVRDX0lTX1BB
VVNFRCwgJmF0Y2hhbi0+c3RhdHVzKSkNCg0KVGhlIHN0YXR1cyBtYXkgY2hhbmdlIGFmdGVyIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoKS4gU2hvdWxkIHRoZSByZXNpZHVlDQpiZSBpbiBzeW5jIHdp
dGggdGhlIGRtYSBzdGF0dXM/IElmIHllcywgeW91IHNob3VsZCBjaGVjayB0aGUgc3RhdHVzIHdo
aWxlDQpob2xkaW5nIHRoZSBsb2NrLg0KDQo+ICsgICAgICAgICAgICAgICBkbWFfc3RhdHVzID0g
RE1BX1BBVVNFRDsNCj4gKw0KPiAgICAgICAgIGRldl92ZGJnKGNoYW4yZGV2KGNoYW4pLCAidHhf
c3RhdHVzICVkOiBjb29raWUgPSAlZCByZXNpZHVlID0gJXVcbiIsDQo+ICAgICAgICAgICAgICAg
ICAgZG1hX3N0YXR1cywgY29va2llLCByZXNpZHVlKTsNCj4gDQo+IC0tDQo+IDIuMzUuMQ0KPiAN
Cg0KLS0gDQpDaGVlcnMsDQp0YQ0KDQo=
