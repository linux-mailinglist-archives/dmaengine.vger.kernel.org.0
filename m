Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903F636CA3B
	for <lists+dmaengine@lfdr.de>; Tue, 27 Apr 2021 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhD0RUg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Apr 2021 13:20:36 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:50440
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235647AbhD0RUf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Apr 2021 13:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOlFrDOdLK55ulAUi7HjVhxnyTQEx5Cz6JBQclpsPOFpCqWd/W/9O5lvNu/qBaJ0jWXYI7E6zcHI/90+cwZoHOq89tNJOjYae7zqY0kooglCluY4vpj9EEImzbKbc8bZF39YMd2JzyltNj0jZiIPxL/9vkJSXpVPPy7EVDTbMT82i8viZSnYavT1ro/Q6Jsyp2OIs+W3bPVVPOwMQ8Z7NMfdP7xjwuTTfg7r1cZtQfmbK94CbPoub5IBGBNYKpeUVyvDVxNKECYyoVNMx4hKhJjxwhIiY7X3xmuUmHq/6TcVpu89JdA+ktzuN+DZ4bV/9gmNAjBt/LYMtCIRZBm09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87rIduHLBiJE9O76NqrkLlmnIVl+YnRdmWSe+hyLp9Q=;
 b=eFYkosLgytbu+/BdL3hxpSD7K1jEaPkd3vBhjKMdoxEEItu2w+b9Wcw8btFoXVYzwyISepUiP6jD1aIhXmPVqTWScL5tdFZO5QzSSmAtcadsol2sFhh3lbWs6sGV2KxPwjUMEzn+0tV6kE+XmfjmrL8WyrFBQ7dNxDCOJI/YI6BxklTe4YRxfEHQf3NU1oD6jIuEA6JtBf7Xa/hJmoCtJ3bBlaQh6fCDV8HXo2Y3+tKNw6HihKVOiy/2uP2CzNDMQftNUQG0Hv0Atvw4Gcj+FhWN2hwJE9rtTXpdRNv0pKF8v7kK9F3GxnaAlcQA40HPTd7pQrca52SO6Hs5V6f2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87rIduHLBiJE9O76NqrkLlmnIVl+YnRdmWSe+hyLp9Q=;
 b=Wd5Hpw0HeXBS1JilIpekEnxDyj1Z7T6tbdl929ll7b4iIw1qVUJb4qESKhSzWtFzugDSAQFnA4nuenoy0Dl1Iclhbj5Lb4U9nVk/daLhxNZ6mohjcl+jOgDjEz+DYG/H2t0mMSnAn7J3Se+OlCKYjf4Ep2+n/6aNo5cPrWsCSsw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR3PR06MB6764.eurprd06.prod.outlook.com (2603:10a6:102:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 17:19:49 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 17:19:49 +0000
Date:   Tue, 27 Apr 2021 19:19:35 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     vkoul@kernel.org, sr@denx.de, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: altera msgdma driver has no dt support
Message-ID: <YIhHp4MfgnrkM1if@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::11) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 17:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1899a2e6-23ab-4cf3-980a-08d909a0a9a3
X-MS-TrafficTypeDiagnostic: PR3PR06MB6764:
X-Microsoft-Antispam-PRVS: <PR3PR06MB6764A7990874D111BA114ABA8F419@PR3PR06MB6764.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzfURr09g5kkrTj3yXOszD+euR9tEevM32eX0pCaUfVjnVlBYwtfAP4Hy9OVMfNPxfIzN6ye1yXo2sHfUhjLutWk3yjJBkgSolCr9UCWnSjWlau0TAfCBhounIGlcRYIHCFeCBwwPieti6m6kly2x+xYUKhermNfoIBs8daW/YY8nuejhAim9TVnNmyV03l1fKP+JTg1aVQaUCVMYdpqsfNqQqqVmHlT3mWPehyH5WBwXS9FvpTQdUgKpewG00dTBxz1TESQN1GzXNk2jTVInqrEjQrYVbzU/GSVi71m8PNL4f/YqfqKQa6MwIzp/AGvSdA16xe3lGW4bqnITKpSn4RZHR/yfHvOfmiePsHJqPvz0E29Xl2o1xp9vsbZpvceUNs4N1PFfiSlus/B4a+XFwpmPWaFf/I6pM7xvXZs2eY9SUu63NDPIV05zWsvHKLCQzucVPPda4Mk46RdKXOvDhdDBwZgYmBAbRlQUWeY/TQ+PgiJldTrZyZBGsbxUzE1+3WpOPSn08+cao5zY5ezUbBNwo3ixIszHXZgtXM6/dAC5HEUtf+ZEu8KS9BoYEMc5/jmHMXBM0bMMjEnCA366iq1UzHEKtD65miLZyKDJo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(376002)(136003)(366004)(346002)(8936002)(44832011)(316002)(7696005)(16526019)(6666004)(86362001)(66946007)(8676002)(4744005)(38100700002)(55016002)(36756003)(2616005)(478600001)(8886007)(66556008)(186003)(2906002)(66476007)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUxUYVZyN09ZVjMremFnOGJtbWJDbWt1aWtJak04S3QxeHN2cmRPOVdCQ2dF?=
 =?utf-8?B?NERLQlc2RmwxcStucUlxMVhXV1pGc1FubXlmcWwvdlZJZkFNZkExTXk5TjZJ?=
 =?utf-8?B?WkRmekhidU5vNzVPdjd2bEdjWXY2YThCUytCTlpwNlhyQSsvM2QrN0ZWWkpw?=
 =?utf-8?B?eVlCT0ZtRm8zQ3lxa0lVQXBSVFJ3aWZXTkRqZ1pOMmE4NFRjMm5zSno1WG9C?=
 =?utf-8?B?cElPaVlNY2JvdUZKUVlSaVhNcnd6SEorTHJjL0ZTUHp4TmxxMlQvTjd1SkM1?=
 =?utf-8?B?dVJWd2FJelpBZFozZ0JNUzJFcFJaK1lqaWllc01NcXRTZzMwV3c1bUZCaXlD?=
 =?utf-8?B?K1VsRmZENktldHQyVDE1V3czZjdpK2xNUCtBQ21rWHQ0c1M1aTRkeVJmTjQv?=
 =?utf-8?B?RFpuekdYclJ5MENUWGljKzRFWnV3ckxSVVE2Um14TjFUZElFVXNzOVpMZmpr?=
 =?utf-8?B?bEFvR3NIcWplYUxLSUpoTDRRMlE2UkZjdjVNNXNZS2xMaTdMTStOVFVBUUFz?=
 =?utf-8?B?eGx5RTB5T2NkYVNwMGkxUVdsZjBUZjdaUFVqQ25xRFEzZ0pZVWZhUEZNSHJB?=
 =?utf-8?B?Y3MvMSt2bUcrTU9CaWlhWWYrYTVaSWdiZk4wZEgxTGVvR2tWRHBrTVgzV3JY?=
 =?utf-8?B?eWNIRk5mWWZmQ1cvRlM1Y01TVnpVOEJseVN5d2hYQTRTZ1UxL20wVVRmeHJD?=
 =?utf-8?B?TDExUHhncFlrb01XbGE0TjN3aVkwTytOVU5XeTJmRTdtK0d0bjNJWDZ1eWIx?=
 =?utf-8?B?NTJSbjF6SENNNjIrZmh3Zmw5YVpDRWpvMjZsck9uQ3c5RWFNZDYwNlpHMllo?=
 =?utf-8?B?T24yaDFvWmYxaXhOWklubXpvRld5MzV5Sy9uSlNQdXZHaENhaTZwaGp4T3hY?=
 =?utf-8?B?Z0tXY2VJalVnVm5XQUdBTStuZ044ejAyVURsZUx4ajlqWFJrN3dDb3ZjUlQ3?=
 =?utf-8?B?VGs1Nmt2UmI1MUZ4T2VuZWoxVDY1dm9NMnNlRTEwRXQ1d2lYOFFLR2FPOEdh?=
 =?utf-8?B?L2thVEpKWmRmeW5XK1ZWQ2hZaUxWNXQ2cCtyTzU3MGhuN3RWM2x3bnAvMlhk?=
 =?utf-8?B?YlJVMzdTbjhQbWNsYzZtUFVVSzRHdldtcmozYTNxZldlUXB0bG9vbUdyZ1hS?=
 =?utf-8?B?NDhlK3VqRHRSOGE3cmZxVGk1VURubzRZQTVRTUM1REFtcVNCd1N2Z2xKVEdY?=
 =?utf-8?B?RTEyQ21ZRTVxVndsMzQ4OGM5bzV1elo2WlJndlVxSEZFQ1AwY25EUnNlWlhT?=
 =?utf-8?B?V244ZmtDcDFzRDI2Ry9EKzJYUW0wS3NtRXczWElQb2ZFZEtCY2dyOERqYWNN?=
 =?utf-8?B?K0dRdHpMSkhEUExrOTA2UTQxT0FOQWt4aEdMTjduKy9HVkFLVzgzQW95YnFk?=
 =?utf-8?B?M2dBMTNYRlF0dVpXY2pWNFUvRnphNm1HQ0l5NVNOU1RjTllGZ3ZtNlhZK3Zq?=
 =?utf-8?B?S3RUaWhlekpHaThwWDl3MmxsU2tTNE1LTEI4Ly9HK0RJaWMxSE9iY0lQL0dx?=
 =?utf-8?B?amdINzdEajhtRzhrSU1VT3o5bnpMcnFlbkdZck5iYXE5TjQwSTlBU0NDOXV2?=
 =?utf-8?B?VUxKTHJQRXdXek9Pb1Bjd3dVZUlMY0xIOCtvQ1ZIb2hRNlRlajNaWS9JRzN5?=
 =?utf-8?B?Sk1zODZ3ZTVsNndneUE3MzNDbk9pNytEd3ZrVklJdkRrU0hYVHMwTGtzS1hW?=
 =?utf-8?B?QTBMQy8zRzc2dW1TM0ZsbzRiYXB4UjlFQkdWRzBOMUxGbmlheFVMbGJNcTBT?=
 =?utf-8?B?NkhVcDdzVVNNb250WW9hNGNQY3ZrTVNZSkhvQkNrZ09rb25BQkVVZkxsMlBh?=
 =?utf-8?B?ekxEQVpkdEtYWmwvRWxmQXJuSUQrUlZ3aW1vODlnaTJ2a0laNzZ5anB6ZHNp?=
 =?utf-8?Q?SX4go42KHnjop?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1899a2e6-23ab-4cf3-980a-08d909a0a9a3
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 17:19:49.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VGNtKAqNKQfRu5k6cJpnQBa1eTHFQeNahT2qi8dNCkWjUESMroeoX3GlDk/jw1SnV0cwggy0U/ljo1dAeHvL8S4cp/3hAnnX0OAGPUXrn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6764
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello all.

The altera msgdma driver located in drivers/dma/altera-msgdma.c
has no support in the devicetree.

How this driver is supposed to work without any dt bindings,
am i missing something here ?

I added basic support in the dt and was able to use the controller
on my platform. I am willing to send a patch if that is required.
Who should I add as mainteners in the dt yaml schema and in the
MAINTENERS file ?


Thank you.

--
Olivier Dautricourt

