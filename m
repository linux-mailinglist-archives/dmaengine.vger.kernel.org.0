Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA8575F85
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jul 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGOKrl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jul 2022 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGOKrj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Jul 2022 06:47:39 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942083F24
        for <dmaengine@vger.kernel.org>; Fri, 15 Jul 2022 03:47:35 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F9fnOW020929;
        Fri, 15 Jul 2022 06:47:23 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3h76a9guxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 06:47:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF1ntgZs6eZr/AO6qu0xZm6MUg/7pCV2fGKG+0Oi5jPIAXqSMHfsIov3SMULVW92qQJeeuDEX70Octp2l2L6L76zzCwy9k0UNCJFtjKsPGp42utAQHYK/4LpUleQP3J7piJqfcM6DYEhPLUIbEZ5zZNOAlXZR7FT8JrLae2ljWYliaBkTKgqv8ZMhtSNLH7oaV99zA5V/egguwVuw7aVpbBKvF3Jn5o7qR/2OAoViVX2zK6C1qghR5w9F9dRfqnlstv+FtVNp0StX/kqvmEa4ZadDKU0xehE2kygt/kUHgT/+8k4TP7P73Tha3li3vTpwTYF2OTGLWyB9bMAzjMOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rERF0TXzcQc8Cmu0r/XR6V+GAF6N6zjd1YU7/kwXCkQ=;
 b=ERFmzo0yFUb14FFYWSvtTKBeZpqQJQx50kKyrWoxWN9jwATdNkK5SWm74qlfgi+dY+r2a49esMfXVDLm3UFMcaSklYmBWRtsIYnuGk2e5H7+3u4Is3zwvrg2myhDzm5ZA7UmQZwIT50dbbukk4LSxne50oPjRmBhxXgmpgG1T7+9LScq6rR6qba4LrvR5NQDNu4wZ7PYycnKYUNBNhK/g26EYWvsD4UlZEhL2LMRJbJcAj9ZQdQiWfZ8O/n8ISxzSjRYDouCsXUKwlA9uvMeq+wNYNaFs8ljmilvorXlvIr0bR4IEz9tGgtJ4BxECv5h773b/rq1yOJtUVnwUuQQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rERF0TXzcQc8Cmu0r/XR6V+GAF6N6zjd1YU7/kwXCkQ=;
 b=f+oyQOFq4FFLU/0ZYrPt1aOhLfk2lZs8aIOQXChDTn6P/pQZLi8nzVhUrwGHfsF2kD3ivra58emnoPjg9R3a7Kn93QbVUzzm+576Fnt7eAPGsDyUk3XRFUdttt8Jitk/KEKNbQCMoR2KOlcjELhG65jGaBwb5ickEmoDy8gfbGQ=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6268.namprd03.prod.outlook.com (2603:10b6:510:ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 10:47:21 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0%8]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 10:47:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Mathias Tausen <mta@satlab.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] dmaengine: axi-dmac: check cache coherency register
Thread-Topic: [PATCH] dmaengine: axi-dmac: check cache coherency register
Thread-Index: AQHYl3IySid4yPE450qciWtjk4qGka1/QQDQ
Date:   Fri, 15 Jul 2022 10:47:20 +0000
Message-ID: <PH0PR03MB6786D02B3DDFAD0B13A975DB998B9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220714110644.2849191-1-mta@satlab.com>
In-Reply-To: <20220714110644.2849191-1-mta@satlab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE4yVm1OVEpsWVdZdE1EUXlZaTB4TVdWa0xUaGlaamN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEZGxaalV5WldJeExUQTBNbUl0TVRGbFpDMDRZ?=
 =?utf-8?B?bVkzTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpT0Rjeklp?=
 =?utf-8?B?QjBQU0l4TXpNd01qTTFOVFl6T0RnMk1USTBOakFpSUdnOUltdHlkR0ptZFdn?=
 =?utf-8?B?NWRrRTRZekV6TlhSYVdXRXJhV3BQVXpObVZUMGlJR2xrUFNJaUlHSnNQU0l3?=
 =?utf-8?B?SWlCaWJ6MGlNU0lnWTJrOUltTkJRVUZCUlZKSVZURlNVMUpWUms1RFoxVkJR?=
 =?utf-8?B?VVZ2UTBGQlFuTmhWVEZDVDBwcVdVRlhlSEkxVnpNdk9FTjBlbUpIZG14aVpp?=
 =?utf-8?B?OTNTek5OUkVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZJUVVG?=
 =?utf-8?B?QlFVUmhRVkZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZS?=
 =?utf-8?B?UVVKQlFVRkJTbkpxU2tsUlFVRkJRVUZCUVVGQlFVRkJRVUZCU2pSQlFVRkNh?=
 =?utf-8?B?RUZIVVVGaFVVSm1RVWhOUVZwUlFtcEJTRlZCWTJkQ2JFRkdPRUZqUVVKNVFV?=
 =?utf-8?B?YzRRV0ZuUW14QlIwMUJaRUZDZWtGR09FRmFaMEpvUVVkM1FXTjNRbXhCUmpo?=
 =?utf-8?B?QldtZENka0ZJVFVGaFVVSXdRVWRyUVdSblFteEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVG?=
 =?utf-8?B?QlFXNW5RVUZCUjBWQldrRkNjRUZHT0VGamQwSnNRVWROUVdSUlFubEJSMVZC?=
 =?utf-8?B?V0hkQ2QwRklTVUZpZDBKeFFVZFZRVmwzUWpCQlNFMUJXSGRDTUVGSGEwRmFV?=
 =?utf-8?B?VUo1UVVSRlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUTBGQlFVRkJRVU5sUVVGQlFWbFJRbXRCUjJ0QldIZENla0ZIVlVGWmQw?=
 =?utf-8?B?SXhRVWhKUVZwUlFtWkJTRUZCWTJkQ2RrRkhiMEZhVVVKcVFVaFJRV04zUW1a?=
 =?utf-8?B?QlNGRkJZVkZDYkVGSVNVRk5aMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?Q?CQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d68b12-c8c8-4eac-b565-08da664f654c
x-ms-traffictypediagnostic: PH0PR03MB6268:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4k6RHWbdKj6JX8MHaeO5+20qBjRmC3eC1zKtfqV3qHOgPtEZVtnHYzwcGjjpRTidgkL+oGq2gCeTy0mr58lfMoLXYsJkjVD30O67bE1J/6CiAa7WLnBHnW/EtVdH2phzUWDRpt3eUA6EZWpmbRkuZNymLm+VkRU9MIDAaRMa7TMnDHB5XmMRXndYlux7FMvzAYJU10HTkfzXEcVd7WVQ09WHJd7pRa6iEvbMuAUpmlH92YslJfsh+Q95V8YIoN8poXoY2aM+1s8Nw+G7mtyehONcbXG5JeZ7JFp7XLz+5Kf7p2PR5WV/DXzW4GX6PacWYGrjXaRtq92pSCLptmMQWFg6umXtOdw2BRYiKgSIIqUpmnQe21jF67J/dBkQAz+DWd3FBs8Kb5hWtTo1t+yvJAwqEv1AsrjfaRsE0mriawOlxUZgSXfMr9d0T2Sqa+FPoHE7ZASOzrMmGG/iXAW6T+relq7SRSk16MIl573w3RZrFMWQX7jnGL3tz2vlvt4QE4U8hFMJtky2lRXwj8rg+Mlqmap6/8kjHuO0cx64JLGBRJloai1AVj/XidxyoP9sKvCRm6jFCQtrctxKqdc4LK684zQc+ReE+VTs/9GmIJ5O9LFltlxjqR6CUbiD/0MOKBQvWqZIrpUSawRIbqBfYQAldUxP9etwBozlqMemEtugUXChWIbGcYNl08WbMeTX8TBV8av+khZUc/QWR2eUmaKV0igHyzdkdNhSh8eHoj50SPgtiDnRQU4dF1+8nizDIy1jEMtkCHPLZv4BvF3wojUznfrWFQYdmTgbJ3wLo+55DCTuh4PB979CxzhB5ik
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(6506007)(41300700001)(7696005)(71200400001)(53546011)(478600001)(26005)(186003)(4744005)(5660300002)(9686003)(2906002)(55016003)(316002)(110136005)(64756008)(52536014)(8936002)(4326008)(66946007)(66446008)(76116006)(8676002)(66476007)(66556008)(33656002)(38100700002)(86362001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3VEWGNIRkRuU3JUS1RMRGdTV3Z6NVlhUGdvd1BCRld1eWp0MEx1RjNZVjNO?=
 =?utf-8?B?b1dlYmowQi92bHRrazNmU1l1eGpWMk1pTkVNY08wUWM5OCtsdnlWS3BYWE4w?=
 =?utf-8?B?YzYxRiswUkVnaDd0aytoNCtjbW8zTVFZbFcrUEhlYlNUNXRhdHlTZHA2SDhH?=
 =?utf-8?B?WVczdndoZU9wZnVOeDNZQkt6MFFFbGoyT2tvakVodlNhMFU5RU95dE5BdG9Y?=
 =?utf-8?B?dzBqU3lQZFRPV2c1RjQ4bFZldWVYT0pCamVkUEJ0Zk9paEFGUmNsMDRacWU2?=
 =?utf-8?B?R2J3SUJzU3lDM1M0WmNsM2pRTW41bmpYVWFmNEFyMHJXRlluczdieGgrRVhN?=
 =?utf-8?B?Q2FnOVo0WURkZWY1WEhRS0JYZHJUOHU4cjNUQUdGY3dhYzc3eFI3b0l2aGJC?=
 =?utf-8?B?bkhIWDdTZHE3SGRXMXJQZWlzZGM0bCtKdXRNM0FSOGY2OFVsMlQ0R1BTbWdW?=
 =?utf-8?B?aWZKUTQ0YldDRzJIdDJsRjRMTzZSclhrZDI5WFFtZzMva1dXWGFhNUN3VzF3?=
 =?utf-8?B?RGVscGJLQW0yNytaTmJsaVRKMW0xZXBXWjJjQWlEK3FIZklxRjVzSnk0WHcr?=
 =?utf-8?B?YlFoUVZSa1p6OUlMV1lxcnY3LzNjK2VYM3lDNDFKQWlMcjJSUWdadzBmZTJH?=
 =?utf-8?B?dmp0VzFid1Z1ZGZDWU01TlFjZ2xtRGlqUFJxZ2Z3OHRJbkNscUpNWDlxQ1RJ?=
 =?utf-8?B?S3dlcHkyV2RyTVVpZFJDN0l5bTkwMWZDYitmVFFTdjU3SXhsYWtKUyswRHhF?=
 =?utf-8?B?YXVoVmU3WWE3ekpsWnZrOVVLcU9sbmJwODlOaXhDbkZzVnZkc09HQ2h1c3RL?=
 =?utf-8?B?aURkaWJmUWxQUGJzVTA3TVkzeTJ1aUwyZ2lpaHZXTXhpT1RvRzVwMjl1aTZC?=
 =?utf-8?B?aWdkNGFHcnBINFloVEdOeGd4M0t3dkRBa1pLRlZLS3hpMXdwTGRGb3VPWldp?=
 =?utf-8?B?b3h5RVhPZVBoWFlwZ2JDTVF1QTJZN3FJR2J1Q0FkMklya2ExTlc5M1NhdDBC?=
 =?utf-8?B?UldTdmJiUnNxK0FqaXNCdnhLVytiRWtrZnB2blZxTHRGK1VsKzRGY2dOWlpt?=
 =?utf-8?B?cUJqcjg3UlV4dENnY2hsYW1rTW1XSlQrdUdaNkVPWVhZTHAxQTBDSkxpWVdk?=
 =?utf-8?B?MHVtWGNWclM4K3N4NFBqVk0vL005dGpVaTNVd0xEdHJNTmFXcE1tUVAxMFgw?=
 =?utf-8?B?NytFVDJkejNsSWZYcUc2dXJGakVPYVFmZXZGdEhoelZPVGV3SSszZG43ZTJ5?=
 =?utf-8?B?WlJzVC9ET3NGWkk4YlRrNjA0bkw2MlBMVXZWN3pwSEgydzlOZVRDVFRXa0Jo?=
 =?utf-8?B?Ty9oWmFGdHJaSzF0VW45ejNvMjBaQXNIMUJlNHBhMWxOZXlNSDBNTEh4dEVY?=
 =?utf-8?B?cHpjRkpVWm13YXBjTEhobHhLK2dlMkp2a0ZSb0lBQTZ0V2pVMjRaVVNpZTR2?=
 =?utf-8?B?ZzVXd3ByKzhEc3BHU201cFlTTUcwMCtYNCs3ODFDSEkvbm1sV1ljNUs1ek8v?=
 =?utf-8?B?eEd5dDNvcGtBT1VrRGZpQWZLMEs2ektqS1VlZlJiUWJyYkM2SmcxVTVGaGdj?=
 =?utf-8?B?LzEzdEJiQkp1MDhKRVFiKzNJNUljL3pzaVk0MHZXVFY3VUtXeENjNGFGOEJa?=
 =?utf-8?B?dENLcngyLy9jZ2NRR2c0anZWcE5VNEQwVEtJQllQOGlWZ1ZvbEZENVJQNURK?=
 =?utf-8?B?YUtUcXllNWQyQXV3NDNZaGJKT0lYUk1yajE3YklEeFhTK3B1dkZpQy95VUk4?=
 =?utf-8?B?MzA5WDdaZXk2WjJObjBSTlZLVTZQUU9kSVpjQXpiT1hQQmZlanQwM3ltdUln?=
 =?utf-8?B?NnFuVkNHVU8rcFJaS2lVZHFzOGFMdEZzQjcyWmZ3K09kVG5HUnhPSC9LaGxo?=
 =?utf-8?B?UFJLc01adVlHckhEUFdpTnVxTUV3N21kamFHQUZwU1pjZkllYTZqdGU3bHQy?=
 =?utf-8?B?Nml4eklDM2xNRElibjAwMXpuTmpKeXhqN3hocHJNUkFHMVNGTlVaM08wNm9B?=
 =?utf-8?B?cXdPUkRoY1NQblE5bS9rdUNaUFQrUjk4Q3pWdE5xcFBVL2tSTHZmYWhpNkpJ?=
 =?utf-8?B?NmUvWWQ1OTBHRW1sSFU5b0c0NEpFaHFIN1JuZFJhMGM3MnZMcm9UdnkrNU1p?=
 =?utf-8?Q?/5lmSWx93JbH2i3MlygGDYNTm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d68b12-c8c8-4eac-b565-08da664f654c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 10:47:21.3696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZbLvWw+IkBO6dl2cjLNZnJWdNBcGLNFeerjMK7AAe7epXm9TWj6vh1m2yOVpM4n4raeTieS6RSe1WYSl1ASsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6268
X-Proofpoint-GUID: XRWCTs8GjVkWelkxWu6ynrgkAU1jm6Ds
X-Proofpoint-ORIG-GUID: XRWCTs8GjVkWelkxWu6ynrgkAU1jm6Ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_03,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=616
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150046
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBNYXRoaWFzIFRhdXNlbiA8bXRhQHNhdGxhYi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBKdWx5IDE0LCAyMDIyIDE6MDcgUE0NCj4gVG86IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IE1hdGhpYXMgVGF1c2VuIDxtdGFAc2F0bGFiLmNvbT47IExhcnMtUGV0ZXIgQ2xhdXNl
bg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBkbWFlbmdpbmU6IGF4aS1kbWFjOiBjaGVjayBjYWNoZSBjb2hlcmVu
Y3kNCj4gcmVnaXN0ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE1hcmtpbmcgdGhlIERNQSBh
cyBjYWNoZSBjb2hlcmVudCAoZG1hLWNvaGVyZW50IGluIGRldmljZXRyZWUpIGlzDQo+IG9ubHkN
Cj4gc2FmZSB3aXRoIHZlcnNpb25zIG9mIGF4aV9kbWFjIHRoYXQgaGF2ZSB0aGlzIGZlYXR1cmUg
ZW5hYmxlZC4NCj4gDQo+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4N
Cj4gQ2M6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1h
dGhpYXMgVGF1c2VuIDxtdGFAc2F0bGFiLmNvbT4NCj4gLS0tDQoNCkFja2VkLWJ5OiBOdW5vIFPD
oSA8bnVuby5zYUBhbmFsb2cuY29tPg0KDQpCVFcsIE1hdGhpYXMgeW91IHNob3VsZCArY2MgdGhl
IG1haW50YWluZXJzLi4uIFRha2UgYSBsb29rIGF0DQoNCnNjcmlwdHMvZ2V0X21haW50YWluZXIu
cGwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2gsDQogLSBOdW5vIFPDoQ0K
